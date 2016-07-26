//
//  NCursesGeometry.swift
//  Nancy
//
//  Created by James Campbell on 7/26/16.
//  Copyright © 2016 Nancy. All rights reserved.
//

import Foundation

public typealias NFloat = Int32
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

public func NRectContainsRect(_ rect1: NRect, _ rect2: NRect) -> Bool {
    return NRectEqualToRect(rect1, NRectUnion(rect1, rect2))
}

public func NRectEqualToRect(_ rect1: NRect, _ rect2: NRect) -> Bool {
  /* FIXME: It is not clear from the docs if {{0,0},{1,1}} and {{1,1},{-1,-1}}
     are equal or not. (The text seem to imply that they aren't.) */
  return ((rect1.origin.x == rect2.origin.x) &&
          (rect1.origin.y == rect2.origin.y) &&
          (rect1.size.width == rect2.size.width) &&
          (rect1.size.height == rect2.size.height))
}

public func NRectUnion(_ rect1: NRect, _ rect2: NRect) -> NRect {

  var rect = NRect.zero

  /* If both of them are empty we can return r2 as an empty rect,
     so this covers all cases: */
  guard !NRectIsEmpty(rect1) else {
    return rect2
  }

  guard !NRectIsEmpty(rect2) else {
    return rect1
  }

  let rect1 = NRectStandardize(rect1)
  let rect2 = NRectStandardize(rect2)

  rect.origin.x = min(rect1.origin.x, rect2.origin.x)
  rect.origin.y = min(rect1.origin.y, rect2.origin.y)
  rect.size.width = max(rect1.origin.x + rect1.size.width, rect2.origin.x + rect2.size.width)
  rect.size.height = max(rect1.origin.y + rect1.size.height, rect2.origin.y + rect2.size.height)

  return rect
}

public func NRectStandardize(_ rect: NRect) -> NRect {

  var rect = rect

  if (rect.size.width < 0) {
    rect.origin.x += rect.size.width;
    rect.size.width = -rect.size.width;
  }

  if (rect.size.height < 0) {
    rect.origin.y += rect.size.height;
    rect.size.height = -rect.size.height;
  }

  return rect
}

public func NRectIsEmpty(_ rect: NRect) -> Bool {
  guard !NRectIsNull(rect) else {
    return true
  }

  return ((rect.size.width == 0) || (rect.size.height == 0))
}

public func NRectIntersectsRect(_ rect1: NRect, _ rect2: NRect) -> Bool {
    return NRectIsNull(NRectIntersection(rect1, rect2))
}

public func NRectIsNull(_ rect: NRect) -> Bool {
  return ((rect.origin.x == 0) || (rect.origin.y == 0) ||
          (rect.size.width == 0) || (rect.size.height == 0))
}

public func NRectIntersection(_ rect1: NRect, _ rect2: NRect) -> NRect {

    var ret = NRect.zero

    if(rect1.origin.x < rect2.origin.x)
    {
      ret.origin.x = rect2.origin.x
      ret.size.width = rect1.origin.x + rect1.size.width - rect2.origin.x
    }
    else
    {
      ret.origin.x = rect1.origin.x
      ret.size.width = rect2.origin.x + rect2.size.width - rect1.origin.x
    }

    if(rect1.origin.y < rect2.origin.y)
    {
      ret.origin.y = rect2.origin.y
      ret.size.height = rect1.origin.y + rect1.size.height - rect2.origin.y
    }
    else
    {
      ret.origin.y = rect1.origin.y
      ret.size.height = rect2.origin.y + rect2.size.height - rect1.origin.y
    }

    return ret
}
