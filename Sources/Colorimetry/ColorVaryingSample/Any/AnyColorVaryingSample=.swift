//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import SwiftUI
    fileprivate import CoreGraphics
#endif

public struct AnyColorVaryingSample<Sample: ColorSample> {

    // MARK: AnyColorVaryingSample - Initialization

    public init(_ colorVaryingSample: some ColorVaryingSample<Sample>) {
        self.colorVaryingSample = colorVaryingSample
    }

    // MARK: AnyColorVaryingSample - Representation

    private let colorVaryingSample: any ColorVaryingSample<Sample>
}

extension AnyColorVaryingSample: ColorVaryingSample {

    // MARK: ColorVaryingSample - Sample

    public func sampleForVariant(_ sampleVariant: SampleVariant) -> Sample {
        colorVaryingSample.sampleForVariant(sampleVariant)
    }

    // MARK: ColorVaryingSample - 

    #if os(macOS)
        @_documentation(visibility: internal)
        public func _converting<Color: AppKit.NSColor>(to _: Color.Type) -> Color {
            colorVaryingSample._converting(to: Color.self)
        }
    #endif

    #if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: UIKit.UIColor>(to _: Color.Type) -> Color {
            colorVaryingSample._converting(to: Color.self)
        }
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            colorVaryingSample._converting(to: SwiftUI.Color.self)
        }
    #endif
}
