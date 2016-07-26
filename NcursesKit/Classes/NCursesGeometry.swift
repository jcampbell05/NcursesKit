//
//  NCursesGeometry.swift
//  Nancy
//
//  Created by James Campbell on 7/26/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

typealias NRectEdge = CGRectEdge

struct NRect {
    
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

struct NPoint {
    
    static var zero: NPoint {
        return NPoint(x: 0, y: 0)
    }
    
    var x: Int32
    var y: Int32
    
    private func toCGPoint() -> CGPoint {
        return CGPoint(x:CGFloat(x), y:CGFloat(y))
    }
}

struct NSize {
    
    static var zero: NSize {
        return NSize(width: 1, height: 1)
    }
    
    var width: Int32
    var height: Int32
    
    private func toCGSize() -> CGSize {
        return CGSize(width:CGFloat(width), height:CGFloat(height))
    }
}

func NRectContainsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectContainsRect(rectA.toCGRect(), rectB.toCGRect())
}

func NRectIntersectsRect(rectA: NRect, rectB: NRect) -> Bool {
    return CGRectIntersectsRect(rectA.toCGRect(), rectB.toCGRect())
}

func NRectIntersection(rectA: NRect, rectB: NRect) -> NRect {

    let intersection = CGRectIntersection(rectA.toCGRect(), rectB.toCGRect())
    let origin = NPoint(x: Int32(intersection.origin.x), y: Int32(intersection.origin.y))
    let size = NSize(width: Int32(intersection.size.width), height: Int32(intersection.size.height))
    
    return NRect(origin: origin, size: size)
}