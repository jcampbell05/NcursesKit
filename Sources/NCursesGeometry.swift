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
}

public func NRectContainsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectContainsRect(rectA.toCGRect(), rectB.toCGRect())
}

public func NRectIntersectsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectIntersectsRect(rectA.toCGRect(), rectB.toCGRect())
}

public func NRectIntersection(r1: NRect, r2: NRect) -> NRect {

    var ret = NRect.zero

    if(r1.origin.x < r2.origin.x)
    {
      ret.origin.x = r2.origin.x
      ret.size.width = r1.origin.x + r1.size.width - r2.origin.x
    }
    else
    {
      ret.origin.x = r1.origin.x
      ret.size.width = r2.origin.x + r2.size.width - r1.origin.x
    }

    if(r1.origin.y < r2.origin.y)
    {
      ret.origin.y = r2.origin.y
      ret.size.height = r1.origin.y + r1.size.height - r2.origin.y
    }
    else
    {
      ret.origin.y = r1.origin.y
      ret.size.height = r2.origin.y + r2.size.height - r1.origin.y
    }

    return ret
}
