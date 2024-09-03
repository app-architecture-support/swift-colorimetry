//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    fileprivate import os
#endif

#if os(macOS)
    public import AppKit
#endif

public struct OpacitySupportingColorSpace<ColorSpaceType: ColorSpace> {

    // MARK: OpacitySupportingColorSpace - Initialization

    internal init(colorSpace: ColorSpaceType) {
        self.colorSpace = colorSpace
    }

    // MARK: OpacitySupportingColorSpace - Representation

    private let colorSpace: ColorSpaceType
}

extension OpacitySupportingColorSpace: CustomDebugStringConvertible {

    // MARK: CustomDebugStringConvertible
    
    public var debugDescription: String {
        String(reflecting: colorSpace) + "_Op"
    }
}

extension OpacitySupportingColorSpace: ColorSpace {

    // MARK: ColorSpace - Component

    public enum Component: Sendable, Hashable {

        // MARK: OpacitySupportingColorSpace.Component

        case nonOpacity(ColorSpaceType.Component)
        
        case opacity
    }

    public var componentCount: Int {
        colorSpace.componentCount + 1
    }

    // MARK: ColorSpace - ComponentIndex

    public func indexForComponent(_ component: Component) -> ComponentIndex {
        switch component {
            case .nonOpacity(let component):
                colorSpace.indexForComponent(component)
            case .opacity:
                colorSpace.componentCount
        }
    }

    public func componentForIndex(_ componentIndex: ComponentIndex) -> Component {
        if componentIndex == colorSpace.componentCount {
            return .opacity
        }
        return .nonOpacity(colorSpace.componentForIndex(componentIndex))
    }

    // MARK: ColorSpace - ComponentIntensity

    public func defaultIntensityForComponent(_ component: Component) -> ComponentIntensity {
        switch component {
            case .nonOpacity(let component):
                colorSpace.defaultIntensityForComponent(component)
            case .opacity:
                1
        }
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
