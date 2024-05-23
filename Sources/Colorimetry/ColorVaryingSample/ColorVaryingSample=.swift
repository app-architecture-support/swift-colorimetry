//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    fileprivate import class CoreGraphics.CGColor
    public import struct SwiftUI.Color
    fileprivate import func os.os_log
#endif

#if os(macOS)
    public import class AppKit.NSColor
#endif

#if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class UIKit.UIColor
#endif

public protocol ColorVaryingSample<Sample> {

    // MARK: ColorVaryingSample - Sample

    associatedtype Sample: ColorSample

    typealias SampleVariant = ColorSampleVariant

    func sampleForVariant(_ sampleVariant: SampleVariant) -> Sample

    // MARK: ColorVaryingSample - 

    #if os(macOS)
        @_documentation(visibility: internal)
        func _converting<Color: AppKit.NSColor>(to _: Color.Type) -> Color
    #endif

    #if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        func _converting<Color: UIKit.UIColor>(to _: Color.Type) -> Color
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color
    #endif
}

extension ColorVaryingSample {

    // MARK: ColorVaryingSample - _Converting

    #if os(macOS)
        @_documentation(visibility: internal)
        public func _converting<Color: AppKit.NSColor>(to _: Color.Type) -> Color {
            .init(name: nil) { appearance in
                let colorSampleVariant = appearance.colorSampleVariant
                let colorSample = sampleForVariant(colorSampleVariant)
                let systemColorSample = colorSample._converting(to: CoreGraphics.CGColor.self)
                guard let systemColorSample = AppKit.NSColor(cgColor: systemColorSample) else {
                    os.os_log(.error, "unable to create $@ from $@", String(reflecting: AppKit.NSColor.self), String(reflecting: CoreGraphics.CGColor.self))
                    return .init()
                }
                return systemColorSample
            }
        }
    #endif

    #if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: UIKit.UIColor>(to _: Color.Type) -> Color {
            #if os(tvOS) || os(iOS) || os(visionOS)
                .init { traitCollection in
                    let colorSampleVariant = traitCollection.colorSampleVariant
                    let colorSample = sampleForVariant(colorSampleVariant)
                    let systemColorSample = colorSample._converting(to: CoreGraphics.CGColor.self)
                    return .init(cgColor: systemColorSample)

                }
            #elseif os(watchOS)
                let colorSample = sampleForVariant(.init())
                let systemColorSample = colorSample._converting(to: CoreGraphics.CGColor.self)
                return .init(cgColor: systemColorSample)
            #endif
        }
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Type) -> SwiftUI.Color {
            #if os(macOS)
                _converting(to: AppKit.NSColor.self)._converting(to: SwiftUI.Color.self)
            #elseif os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
                _converting(to: UIKit.UIColor.self)._converting(to: SwiftUI.Color.self)
            #endif
        }
    #endif
}
