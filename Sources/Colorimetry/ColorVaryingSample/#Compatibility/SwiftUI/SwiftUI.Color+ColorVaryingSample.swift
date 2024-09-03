//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    public import SwiftUI
    #if os(macOS)
        fileprivate import AppKit
    #endif
    #if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        fileprivate import UIKit
    #endif

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

        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            self
        }
    }
#endif
