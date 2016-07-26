//
//  NCursesWindow.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation
import Darwin.ncurses

class NCursesWindow: NCursesView {
    
    private lazy var keyPressTimer: NSTimer = {
        return NSTimer(timeInterval: 0.02, target: self, selector: #selector(keyPressTimerDidFire), userInfo: nil, repeats: true)
    }()
    
    override var window: NCursesWindow? {
        return self
    }
    
    var hasColors: Bool {
        return has_colors()
    }
    
    override init() {
        
        super.init()
        
        if amIBeingDebugged() {
            setenv("TERM", "dumb", 1) // Make sure we can still debug it under Xcode
        }
        
        setlocale(LC_ALL, "")
        initscr()
        nodelay(stdscr, true)
        
        noecho()
        curs_set(0)
        
        start_color()
        NCursesColor.registerColorPairs()
        
        NSRunLoop.mainRunLoop().addTimer(keyPressTimer, forMode: NSRunLoopCommonModes)
    }
    
    override func needsDisplay() {
        drawContext()
        
        subviews.forEach {
            $0.drawContext()
        }
        
        flushContext()
        refresh()
    }
    
    func makeKeyAndVisible() {
        frame = NRect(origin: NPoint.zero, size: NSize(width:getmaxx(stdscr), height:getmaxy(stdscr)))
        needsDisplay()
    }
    
    private func amIBeingDebugged() -> Bool {
            
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = strideofValue(info)
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    private func keyPressed() -> Bool {
        
        let pressedChracterCode = getch()
        
        if pressedChracterCode != ERR {
            ungetch(pressedChracterCode)
            return true
        } else {
            return false
        }
    }
    
    @objc private func keyPressTimerDidFire() {
        
        guard keyPressed() else {
            return
        }
        
        let pressedCharacterCode = UInt32(getch())
        let characterScalar = UnicodeScalar(pressedCharacterCode)
        let character = Character(characterScalar)
        
        didPressKeyForCharacter(character)
    }
}