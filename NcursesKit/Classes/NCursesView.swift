//
//  NCursesView.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

class NCursesView: NSObject {
    
    // MARK: - Context
    
    private let context: NCursesGraphicsContext
    
    // MARK: - Anchors and Guides
    
    lazy var layoutGuide: NCursesLayoutGuide = {
        return NCursesLayoutGuide(view: self)
    }()
    
    lazy var leftAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Left)
    }()
    
    lazy var topAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Top)
    }()
    
    lazy var rightAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Right)
    }()
    
    lazy var bottomAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Bottom)
    }()
    
    lazy var widthAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Width)
    }()
    
    lazy var heightAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Height)
    }()
    
    // MARK: - Layout
    
    var frame: NRect = NRect.zero {
        didSet {
            context.frame = frame
        }
    }
    
    var bounds: NRect {
        return NRect(origin: NPoint.zero, size: frame.size)
    }
    
    // MARK: - Hiearchy
    
    var window: NCursesWindow? {
        return superview?.window
    }
    
    private(set) var superview: NCursesView?
    private(set) var subviews: [NCursesView] = []
    
    // MARK: - Methods
    
    override init() {
        context = NCursesGraphicsContext(frame: frame)
        super.init()
    }
    
    func drawInContext(context: NCursesGraphicsContext) {
        subviews.forEach {
            $0.drawContext()
        }
    }
    
    func needsDisplay() {
        superview?.needsDisplay()
    }
    
    func drawContext() {
        context.clear()
        drawInContext(context)
    }
    
    func flushContext() {
        
        context.flush()
        
        subviews.forEach {
            $0.flushContextToContext(context)
        }
    }
    
    func flushContextToContext(context: NCursesGraphicsContext) {
        
        self.context.drawToContext(context)
        
        subviews.forEach {
            $0.flushContextToContext(self.context)
        }
    }
    
    func addSubview(view: NCursesView) {
        view.superview = self
        subviews.append(view)
        needsDisplay()
    }
    
    func removeSubview(view: NCursesView) {
        subviews = subviews.filter {
            $0 != view
        }
    }
    
    func removeFromSuperview() {
        superview?.removeSubview(self)
    }
    
    func didPressKeyForCharacter(character: Character) {
        subviews.forEach {
            $0.didPressKeyForCharacter(character)
        }
    }
}