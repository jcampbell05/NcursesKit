//
//  NCursesLayoutAnchor.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

class NCursesLayoutAnchor {
    
    enum Strategy {
        case Left
        case Top
        case Right
        case Bottom
        case Width
        case Height
    }
    
    let view: NCursesView
    let strategy: Strategy
    
    var includeBorderInCalculations = false
    
    private var value: Int32 {
        
        let padding = (includeBorderInCalculations) ? 1 : 0
        
        switch strategy {
        case .Left:
            return view.frame.origin.x + padding
        case .Top:
            return view.frame.origin.y + padding
        case .Right:
            return view.frame.size.width - padding
        case .Bottom:
            return view.frame.size.height - padding
        case .Width:
            return view.frame.size.width - (padding * 2)
        case .Height:
            return view.frame.size.height - (padding * 2)
        }
    }
    
    init(view: NCursesView, strategy: Strategy) {
        self.view = view
        self.strategy = strategy
    }
    
    func constraintEqualToAnchor(anchor: NCursesLayoutAnchor, constant c: Int32 = 0) {
        
        let value = anchor.value + c
        
        switch strategy {
        case .Left:
            view.frame.origin.x = value
            return
        case .Top:
            view.frame.origin.y = value
            return
        case .Right:
            view.frame.origin.x = value - view.frame.size.width
            return
        case .Bottom:
            view.frame.origin.y = value - view.frame.size.height
            return
        case .Width:
            view.frame.size.width = value
            return
        case .Height:
            view.frame.size.height = value
            return
        }
    }
    
    func constraintEqualToConstant(c: Int32) {
        switch strategy {
        case .Left:
            view.frame.origin.x = c
            return
        case .Top:
            view.frame.origin.y = c
            return
        case .Right:
            view.frame.origin.x = c - view.frame.size.width
            return
        case .Bottom:
            view.frame.origin.y = c - view.frame.size.height
            return
        case .Width:
            view.frame.size.width = c
            return
        case .Height:
            view.frame.size.height = c
            return
        }
    }
}