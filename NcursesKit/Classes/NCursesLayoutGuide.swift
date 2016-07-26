//
//  NCursesLayoutGuide.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

class NCursesLayoutGuide {
    
    // MARK: - View
    
    let view: NCursesView
    
    // MARK: - Anchors and Guides
    
    lazy var leftAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Left)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    lazy var topAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Top)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    lazy var rightAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Right)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    lazy var bottomAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Bottom)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    lazy var widthAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Width)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    lazy var heightAnchor: NCursesLayoutAnchor = {
        let anchor = NCursesLayoutAnchor(view: self.view, strategy: .Height)
        anchor.includeBorderInCalculations = true
        return anchor
    }()
    
    // MARK: - View
    
    init(view: NCursesView) {
        self.view = view
    }
}