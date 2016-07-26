//
//  NCursesGeometry.swift
//  Nancy
//
//  Created by James Campbell on 7/26/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

typealias NFloat = Int32
typealias NRectEdge = CGRectEdge

public struct NRect {

    static var zero: NRect {
        return NRect(origin: NPoint.zero, size: NSize.zero)
    }

    var origin: NPoint
    var size: NSize

    func clip(frame: NRect) -> NRect {

        // - Should figure out clipping frame for rect
        // http://stackoverflow.com/questions/4811623/subtract-cgrect-from-cgrect-largest-piece-of-one-not-containing-the-other

        return self
    }

    private func toCGRect() -> CGRect {
        return CGRect(origin:origin.toCGPoint(), size:size.toCGSize())
    }
}

public struct NPoint {

    static var zero: NPoint {
        return NPoint(x: 0, y: 0)
    }

    var x: NFloat
    var y: NFloat

    public init(x: NFloat, y: NFloat) {
        self.x = x
        self.y = y
    }

    private func toCGPoint() -> CGPoint {
        return CGPoint(x:CGFloat(x), y:CGFloat(y))
    }
}

public struct NSize {

    static var zero: NSize {
        return NSize(width: 1, height: 1)
    }

    var width: NFloat
    var height: NFloat

    public init(width: NFloat, height: NFloat) {
        self.width = width
        self.height = height
    }

    private func toCGSize() -> CGSize {
        return CGSize(width:CGFloat(width), height:CGFloat(height))
    }
}

public func NRectContainsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectContainsRect(rectA.toCGRect(), rectB.toCGRect())
}

public func NRectIntersectsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectIntersectsRect(rectA.toCGRect(), rectB.toCGRect())
}

public func NRectIntersection(rectA: NRect, rectB: NRect) -> NRect {

    let intersection = CGRectIntersection(rectA.toCGRect(), rectB.toCGRect())
    let origin = NPoint(x: NFloat(intersection.origin.x), y: NFloat(intersection.origin.y))
    let size = NSize(width: NFloat(intersection.size.width), height: NFloat(intersection.size.height))

    return NRect(origin: origin, size: size)
}
