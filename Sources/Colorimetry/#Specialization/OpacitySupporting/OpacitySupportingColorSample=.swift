//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    fileprivate import SwiftUI
    fileprivate import os
#endif

#if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
    fileprivate import CoreImage
#endif

public struct OpacitySupportingColorSample<ColorSampleType: ColorSample> {

    // MARK: OpacitySupportingColorSample - Initialization

    internal init(colorSample: ColorSampleType, opacity: ComponentIntensity? = nil) {
        self.colorSample = colorSample
        self.opacity = opacity
    }

    // MARK: OpacitySupportingColorSample - Representation

    private let colorSample: ColorSampleType
    private let opacity: ComponentIntensity?
}

extension OpacitySupportingColorSample: CustomDebugStringConvertible {

    // MARK: CustomDebugStringConvertible

    public var debugDescription: String {
        let defaultOpacity = space.defaultIntensityForComponent(.opacity)
        let opacity = opacity ?? defaultOpacity
        let colorSampleDescription = String(reflecting: colorSample)
        return if opacity != defaultOpacity {
            String(reflecting: opacity) + " * " + colorSampleDescription
        } else {
            colorSampleDescription
        }
    }
}

extension OpacitySupportingColorSample: ColorSample {

    // MARK: ColorSample - Initialization

    public init() {
        self.init(colorSample: .init())
    }

    // MARK: ColorSample - Space

    public typealias Space = OpacitySupportingColorSpace<ColorSampleType.Space>

    public var space: Space {
        .init(colorSpace: colorSample.space)
    }

    // MARK: ColorSample - Component

    public subscript(component component: Component) -> ComponentIntensity? {
        switch component {
            case .nonOpacity(let component):
                colorSample[component: component]
            case .opacity:
                opacity
        }
    }

    // MARK: ColorSample - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            let opacity = opacity ?? space.defaultIntensityForComponent(.opacity)
            guard let color = colorSample._converting(to: Color.self).copy(alpha: opacity) else {
                os.os_log(.error, "unable to create %@ from %@: unable to modify opacity", String(reflecting: Color.self), String(reflecting: Self.self))
                return .init()
            }
            return color._converting(to: Color.self)
        }
    #endif
}
