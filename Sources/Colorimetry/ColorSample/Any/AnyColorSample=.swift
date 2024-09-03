//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    public import SwiftUI
#endif

#if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
    fileprivate import CoreImage
#endif

public struct AnyColorSample<Space: ColorSpace> {

    // MARK: AnyColorSample - Initialization

    public init(_ colorSample: some ColorSample<Space>) {
        self.colorSample = colorSample
    }

    // MARK: AnyColorSample - Representation

    private var colorSample: any ColorSample<Space>
}

extension AnyColorSample: ColorSample {

    // MARK: ColorSample - Component

    public var space: Space {
        colorSample.space
    }

    public subscript(component component: Component) -> ComponentIntensity? {
        Self[component: component, using: colorSample]
    }

    // MARK: ColorSample - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            colorSample._converting(to: Color.self)
        }

        @_documentation(visibility: internal)
        @_spi_available(macOS 14.0, tvOS 17.0, iOS 17.0, watchOS 10.0, *)
        public func _converting(to _: SwiftUI.Color.Resolved.Type) -> SwiftUI.Color.Resolved {
            colorSample._converting(to: SwiftUI.Color.Resolved.self)
        }
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: CoreImage.CIColor>(to _: Color.Type) -> Color {
            colorSample._converting(to: Color.self)
        }
    #endif
}

extension AnyColorSample {

    // MARK: AnyColorSample - ColorSample

    private static subscript(
        component component: Component,
        using colorSample: some ColorSample<Space>
    ) -> ComponentIntensity? {
        colorSample[component: component]
    }
}
