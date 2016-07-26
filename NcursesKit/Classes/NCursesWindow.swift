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
    
    init(frame: NRect) {
        
        super.init()
        
        self.frame = frame
        
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
        needsDisplay()
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