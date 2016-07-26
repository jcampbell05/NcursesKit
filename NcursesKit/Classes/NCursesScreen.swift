//
//  NCursesScreen.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

public class NCursesScreen {
    
    public var bounds: NRect {
        return NRect(origin: NPoint.zero, size: NSize(width:getmaxx(stdscr), height:getmaxy(stdscr)))
    }
    
    private var hasColors: Bool {
        return has_colors()
    }
    
    public init() {
        
        if amIBeingDebugged() {
            setenv("TERM", "dumb", 1) // Make sure we can still debug it under Xcode
        }
        
        setlocale(LC_ALL, "")
        initscr()
        nodelay(stdscr, true)
        
        noecho()
        curs_set(0)
        
        if hasColors {
            start_color()
            NCursesColor.registerColorPairs()
        }
    }
    
    private func amIBeingDebugged() -> Bool {
        
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = strideofValue(info)
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
}