//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
#endif

#if os(macOS)
    public import AppKit
#endif

public struct AnyColorSpace<Component: Hashable> {

    // MARK: AnyColorSpace - Initialization

    public init(_ colorSpace: some ColorSpace<Component>) {
        self.colorSpace = colorSpace
    }

    // MARK: AnyColorSpace - Representation

    private var colorSpace: any ColorSpace<Component>
}

extension AnyColorSpace: ColorSpace {

    // MARK: ColorSpace - Component

    public var componentCount: Int {
        colorSpace.componentCount
    }

    // MARK: ColorSpace - ComponentIndex

    public func indexForComponent(_ component: Component) -> ComponentIndex {
        colorSpace.indexForComponent(component)
    }

    public func componentForIndex(_ componentIndex: ComponentIndex) -> Component {
        colorSpace.componentForIndex(componentIndex)
    }

    // MARK: ColorSpace - ComponentIntensity

    public func defaultIntensityForComponent(_ component: Component) -> ComponentIntensity {
        colorSpace.defaultIntensityForComponent(component)
    }

    // MARK: ColorSpace - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<ColorSpace: CoreGraphics.CGColorSpace>(to _: ColorSpace.Type) -> ColorSpace {
            colorSpace._converting(to: ColorSpace.self)
        }
    #endif

    #if os(macOS)
        @_documentation(visibility: internal)
        public func _converting<ColorSpace: AppKit.NSColorSpace>(to _: ColorSpace.Type) -> ColorSpace {
            colorSpace._converting(to: ColorSpace.self)
        }
    #endif
}
