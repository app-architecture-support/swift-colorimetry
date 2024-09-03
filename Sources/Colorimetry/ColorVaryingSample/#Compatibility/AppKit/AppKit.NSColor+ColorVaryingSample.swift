//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    public import CoreGraphics
    public import SwiftUI
    fileprivate import os

    extension AppKit.NSColor: ColorVaryingSample {

        // MARK: ColorVaryingSample - Sample

        public typealias Sample = CoreGraphics.CGColor

        public func sampleForVariant(_ sampleVariant: SampleVariant) -> Sample {
            let appearance = AppKit.NSAppearance(colorSampleVariant: sampleVariant)
            if #available(macOS 11.0, *) {
                var sample: Sample?
                appearance.performAsCurrentDrawingAppearance {
                    sample = cgColor
                }
                if let sample {
                    return sample
                } else {
                    os.os_log(.error, "unable to create $@ from $@: unable to apply $@", String(reflecting: Sample.self), String(reflecting: Self.self), String(reflecting: SampleVariant.self))
                    return .init(gray: 0, alpha: 0)
                }
            } else {
                let existingAppearance = AppKit.NSAppearance.current
                defer {
                    AppKit.NSAppearance.current = existingAppearance
                }
                AppKit.NSAppearance.current = appearance
                return cgColor
            }
        }

        // MARK: ColorVaryingSample - _Converting

        @_documentation(visibility: internal)
        public func _converting<Color: AppKit.NSColor>(to _: Color.Type) -> Color {
            if let color = self as? Color {
                return color
            }
            return .init(name: nil) { appearance in
                guard let color = Color(cgColor: self.sampleForVariant(appearance.colorSampleVariant)) else {
                    os.os_log(.error, "unable to create $@ from $@", String(reflecting: Color.self), String(reflecting: Self.self))
                    return .init()
                }
                return color
            }
        }
        
        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            if #available(macOS 12.0, *) {
                .init(nsColor: self)
            } else {
                .init(self)
            }
        }
    }
#endif
