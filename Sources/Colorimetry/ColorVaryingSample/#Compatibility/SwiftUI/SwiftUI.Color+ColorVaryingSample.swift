//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    public import SwiftUI

    @available(macOS 11.0, tvOS 14.0, iOS 14.0, watchOS 7.0, *)
    extension SwiftUI.Color: ColorVaryingSample {

        // MARK: SwiftUI.Color - Sample

        public typealias Sample = CoreGraphics.CGColor

        public func sampleForVariant(_ sampleVariant: SampleVariant) -> Sample {
            #if os(macOS)
                AppKit.NSColor(self).sampleForVariant(sampleVariant)
            #elseif os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
                UIKit.UIColor(self).sampleForVariant(sampleVariant)
            #endif
        }

        // MARK: ColorVaryingSample - _Converting
        
        #if os(macOS)
            @_documentation(visibility: internal)
            public func _converting<Color: AppKit.NSColor>(to _: Color.Type) -> Color {
                AppKit.NSColor(self)._converting(to: Color.self)
            }
        #endif

        #if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
            @_documentation(visibility: internal)
            public func _converting<Color: UIKit.UIColor>(to _: Color.Type) -> Color {
                UIKit.UIColor(self)._converting(to: Color.self)
            }
        #endif

        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            self
        }
    }
#endif
