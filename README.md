# NcursesKit

NcursesKit is an attempt to implement a pseudo-UIKit inspired API for Ncurses in
Swift (and eventually Objective-C).

[![CI Status](http://img.shields.io/travis/James Campbell/NcursesKit.svg?style=flat)](https://travis-ci.org/James Campbell/NcursesKit)
[![Version](https://img.shields.io/cocoapods/v/NcursesKit.svg?style=flat)](http://cocoapods.org/pods/NcursesKit)
[![License](https://img.shields.io/cocoapods/l/NcursesKit.svg?style=flat)](http://cocoapods.org/pods/NcursesKit)
[![Platform](https://img.shields.io/cocoapods/p/NcursesKit.svg?style=flat)](http://cocoapods.org/pods/NcursesKit)

## Example

Documentation TBC.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NcursesKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NcursesKit"
```

# Roadmap

- Remove flicker from screen updates.
- Implement layout engine inspired by Auto-Layout and Springs & Structs (Layout anchors right now are experimental).
- Have full layer clipping support (Currently clips but doesn't render correctly).
- Fix corrupted CLI after a Ncurses session.
- Implement widgets from UIKit.
- Implement focus engine from tvOS or some sort of alternative.
- Bring parity to UIKit where possible.

## Author

James Campbell, james@supmenow.com

## License

NcursesKit is available under the MIT license. See the LICENSE file for more info.
