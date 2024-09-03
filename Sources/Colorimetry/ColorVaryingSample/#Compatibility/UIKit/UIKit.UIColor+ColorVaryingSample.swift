//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    public import SwiftUI
    fileprivate import UIKit
    fileprivate import os

    extension UIKit.UIColor: ColorVaryingSample {

        // MARK: ColorVaryingSample - Sample

        public typealias Sample = CoreGraphics.CGColor

        public func sampleForVariant(_ sampleVariant: SampleVariant) -> Sample {
            #if os(tvOS) || os(iOS) || os(visionOS)
                let traitCollection = UIKit.UITraitCollection(colorSampleVariant: sampleVariant)
                var sample: Sample?
                traitCollection.performAsCurrent {
                    sample = cgColor
                }
                if let sample {
                    return sample
                } else {
                    os.os_log(.error, "unable to create $@ from $@: unable to apply $@", String(reflecting: Sample.self), String(reflecting: Self.self), String(reflecting: SampleVariant.self))
                    return .init()
                }
            #elseif os(watchOS)
                return cgColor
            #endif
        }

        // MARK: ColorVaryingSample - _Converting

        @_documentation(visibility: internal)
        public func _converting<Color: UIKit.UIColor>(to _: Color.Type) -> Color {
            if let color = self as? Color {
                return color
            }
            #if os(tvOS) || os(iOS) || os(visionOS)
                return .init { traitCollection in
                    Color(cgColor: self.sampleForVariant(traitCollection.colorSampleVariant))
                }
            #elseif os(watchOS)
                return Color(cgColor: self.sampleForVariant(.init()))
            #endif
        }

        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            if #available(tvOS 15.0, iOS 15.0, watchOS 8.0, *) {
                .init(uiColor: self)
            } else {
                .init(self)
            }
        }
    }
#endif
