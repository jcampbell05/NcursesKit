//
//  NCursesView.swift
//  Nancy
//
//  Created by James Campbell on 7/25/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

public class NCursesView: NSObject {

    // MARK: - Context

    private let context: NCursesGraphicsContext

    // MARK: - Anchors and Guides

    public lazy var layoutGuide: NCursesLayoutGuide = {
        return NCursesLayoutGuide(view: self)
    }()

    public lazy var leftAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Left)
    }()

    public lazy var topAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Top)
    }()

    public lazy var rightAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Right)
    }()

    public lazy var bottomAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Bottom)
    }()

    public lazy var widthAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Width)
    }()

    public lazy var heightAnchor: NCursesLayoutAnchor = {
        return NCursesLayoutAnchor(view: self, strategy: .Height)
    }()

    // MARK: - Layout

    public var frame: NRect = NRect.zero {
        didSet {
            context.frame = frame
        }
    }

    public var bounds: NRect {
        return NRect(origin: NPoint.zero, size: frame.size)
    }

    // MARK: - Hiearchy

    var window: NCursesWindow? {
        return superview?.window
    }

    private(set) var superview: NCursesView?
    private(set) var subviews: [NCursesView] = []

    // MARK: - Methods

    override public init() {
        context = NCursesGraphicsContext(frame: frame)
        super.init()
    }

    public func drawInContext(context: NCursesGraphicsContext) {
        subviews.forEach {
            $0.drawContext()
        }
    }

    public func needsDisplay() {
        superview?.needsDisplay()
    }

    func drawContext() {
        context.clear()
        drawInContext(context: context)
    }

    func flushContext() {

        context.flush()

        subviews.forEach {
            $0.flushContextToContext(context: context)
        }
    }

    func flushContextToContext(context: NCursesGraphicsContext) {

        self.context.drawToContext(context: context)

        subviews.forEach {
            $0.flushContextToContext(context: self.context)
        }
    }

    public func addSubview(_ view: NCursesView) {
        view.superview = self
        subviews.append(view)
        needsDisplay()
    }

    public func removeSubview(_ view: NCursesView) {
        subviews = subviews.filter {
            $0 != view
        }
    }

    public func removeFromSuperview() {
        superview?.removeSubview(self)
    }

    public func didPressKeyForCharacter(character: Character) {
        subviews.forEach {
            $0.didPressKeyForCharacter(character: character)
        }
    }
}
