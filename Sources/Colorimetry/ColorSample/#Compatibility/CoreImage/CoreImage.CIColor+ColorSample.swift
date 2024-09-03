//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
    public import CoreGraphics
    public import CoreImage
    fileprivate import os

    #if os(macOS)
        fileprivate import AppKit
    #endif

    #if os(tvOS) || os(iOS) || os(visionOS)
        fileprivate import UIKit
    #endif

    extension CoreImage.CIColor: ColorSample {

        // MARK: ColorSample - Space

        public typealias Space = CoreGraphics.CGColorSpace

        public var space: Space {
            colorSpace
        }

        // MARK: ColorSample - Component

        public subscript(component component: Component) -> ComponentIntensity? {
            let components = UnsafeBufferPointer(start: components, count: numberOfComponents)
            let componentIndex = space.indexForComponent(component)
            guard components.indices.contains(componentIndex) else {
                return nil
            }
            return components[componentIndex]
        }
        // MARK: ColorSample - _Converting

        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            #if os(macOS)
                AppKit.NSColor(ciColor: self).cgColor._converting(to: Color.self)
            #elseif os(tvOS) || os(iOS) || os(visionOS)
                UIKit.UIColor(ciColor: self).cgColor._converting(to: Color.self)
            #endif
        }

        @_documentation(visibility: internal)
        public func _converting<Color: CoreImage.CIColor>(to _: Color.Type) -> Color {
            if let color = self as? Color {
                return color
            }
            return .init(cgColor: _converting(to: CoreGraphics.CGColor.self))
        }
    }
#endif
