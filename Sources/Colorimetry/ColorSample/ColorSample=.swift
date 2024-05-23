//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class CoreGraphics.CGColor
    public import struct SwiftUI.Color
    fileprivate import class CoreGraphics.CGColorSpace
    fileprivate import struct CoreGraphics.CGFloat
    fileprivate import func os.os_log
#endif

#if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
    public import class CoreImage.CIColor
#endif

public protocol ColorSample {

    // MARK: ColorSample - Initialization

    init()

    // MARK: ColorSample - Space

    associatedtype Space: ColorSpace

    var space: Space { get }

    // MARK: ColorSample - Component

    typealias Component = Space.Component

    typealias ComponentIntensity = Space.ComponentIntensity

    subscript(component component: Component) -> ComponentIntensity? { get }

    // MARK: ColorSample - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color

        @_documentation(visibility: internal)
        @_spi_available(macOS 14.0, tvOS 17.0, iOS 17.0, watchOS 10.0, *)
        func _converting(to _: SwiftUI.Color.Resolved.Type) -> SwiftUI.Color.Resolved
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
        @_documentation(visibility: internal)
        func _converting<Color: CoreImage.CIColor>(to _: Color.Type) -> Color
    #endif
}

extension ColorSample {

    // MARK: ColorSample - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            let colorSpace = space._converting(to: CoreGraphics.CGColorSpace.self)
            return withUnsafeTemporaryAllocation(of: CoreGraphics.CGFloat.self, capacity: colorSpace.numberOfComponents + 1) { colorComponentListBuffer in
                guard let colorComponentListBufferAddress = colorComponentListBuffer.baseAddress else {
                    os.os_log(.error, "unable to create %@ from %@: missing color component list", String(reflecting: Color.self), String(reflecting: Self.self))
                    return .init()
                }
                for colorComponentIndex in 0 ..< colorSpace.numberOfComponents {
                    let colorComponent = space.componentForIndex(colorComponentIndex)
                    colorComponentListBuffer[colorComponentIndex] = self[component: colorComponent] ?? space.defaultIntensityForComponent(colorComponent)
                }
                colorComponentListBuffer[colorSpace.numberOfComponents] = 1
                let color = Color(colorSpace: colorSpace, components: colorComponentListBufferAddress)
                guard let color else {
                    os.os_log(.error, "unable to create %@ from %@: incorrect color space or color component list", String(reflecting: Color.self), String(reflecting: Self.self))
                    return .init()
                }
                return color
            }
        }

        @_documentation(visibility: internal)
        @_spi_available(macOS 14.0, tvOS 17.0, iOS 17.0, watchOS 10.0, *)
        public func _converting(to _: SwiftUI.Color.Resolved.Type) -> SwiftUI.Color.Resolved {
            SwiftUI.Color(cgColor: _converting(to: CoreGraphics.CGColor.self)).resolve(in: .init())
        }
    #endif

    #if os(macOS) || os(tvOS) || os(iOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<Color: CoreImage.CIColor>(to _: Color.Type) -> Color {
            .init(cgColor: _converting(to: CoreGraphics.CGColor.self))
        }
    #endif
}
