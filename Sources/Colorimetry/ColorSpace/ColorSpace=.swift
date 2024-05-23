//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class CoreGraphics.CGColorSpace
    fileprivate import func os.os_log
#endif

#if os(macOS)
    public import class AppKit.NSColorSpace
#endif

public protocol ColorSpace {

    // MARK: ColorSpace - Component

    associatedtype Component: Sendable, Hashable

    var componentCount: Int { get }

    // MARK: ColorSpace - ComponentIndex

    typealias ComponentIndex = Int

    func indexForComponent(_ component: Component) -> ComponentIndex

    func componentForIndex(_ componentIndex: ComponentIndex) -> Component

    // MARK: ColorSpace - ComponentIntensity

    typealias ComponentIntensity = Float64

    func defaultIntensityForComponent(_ component: Component) -> ComponentIntensity

    // MARK: ColorSpace - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        func _converting<ColorSpace: CoreGraphics.CGColorSpace>(to _: ColorSpace.Type) -> ColorSpace
    #endif

    #if os(macOS)
        @_documentation(visibility: internal)
        func _converting<ColorSpace: AppKit.NSColorSpace>(to _: ColorSpace.Type) -> ColorSpace
    #endif
}

extension ColorSpace {

    // MARK: ColorSpace - _Converting

    #if os(macOS)
        @_documentation(visibility: internal)
        public func _converting<ColorSpace: AppKit.NSColorSpace>(to _: ColorSpace.Type) -> ColorSpace {
            guard let colorSpace = ColorSpace(cgColorSpace: _converting(to: CoreGraphics.CGColorSpace.self)) else {
                os.os_log(.error, "unable to create %@ from %@", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                return .init()
            }
            return colorSpace
        }
    #endif
}
