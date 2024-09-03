//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    fileprivate import os

    extension CoreGraphics.CGColorSpace: ColorSpace {

        // MARK: CoreGraphics.CGColorSpace - Component

        public struct Component: Sendable, Hashable {

            // MARK: CoreGraphics.CGColorSpace.Component - Initialization

            fileprivate init(index: Index) {
                self.index = index
            }

            // MARK: CoreGraphics.CGColorSpace.Component - Representatin

            fileprivate typealias Index = CoreGraphics.CGColorSpace.ComponentIndex

            fileprivate let index: Index
        }

        public var componentCount: Int {
            numberOfComponents
        }

        // MARK: CoreGraphics.CGColorSpace - Index

        public func indexForComponent(_ component: Component) -> ComponentIndex {
            component.index
        }

        public func componentForIndex(_ componentIndex: ComponentIndex) -> Component {
            .init(index: componentIndex)
        }

        // MARK: ColorSpace - ComponentIntensity

        public func defaultIntensityForComponent(_ component: Component) -> ComponentIntensity {
            0
        }

        // MARK: CoreGraphics.CGColorSpace - _Converting

        @_documentation(visibility: internal)
        public func _converting<ColorSpace: CoreGraphics.CGColorSpace>(to _: ColorSpace.Type) -> ColorSpace {
            if let colorSpace = self as? ColorSpace {
                return colorSpace
            }
            if let colorSpaceName = name {
                guard let colorSpace = ColorSpace(name: colorSpaceName) else {
                    os.os_log(.error, "unable to create %@ from %@: incorrect color space name: $@", String(reflecting: ColorSpace.self), String(reflecting: Self.self), String(reflecting: colorSpaceName))
                    preconditionFailure()
                }
                return colorSpace
            }
            if let propertyList = copyPropertyList() {
                guard let colorSpace = ColorSpace(propertyListPlist: propertyList) else {
                    os.os_log(.error, "unable to create %@ from %@: incorrect color space property list", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                    preconditionFailure()
                }
                return colorSpace
            }
            if let iccData = copyICCData() {
                guard let colorSpace = ColorSpace(iccData: iccData) else {
                    os.os_log(.error, "unable to create %@ from %@: incorrect color space ICC profile", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                    preconditionFailure()
                }
                return colorSpace
            }
            switch model {
                case .indexed:
                    guard let baseColorSpace else {
                        os.os_log(.error, "unable to create %@ from %@: indexed color space: missing base color space", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                        preconditionFailure()
                    }
                    guard let colorTable else {
                        os.os_log(.error, "unable to create %@ from %@: indexed color space: missing color table", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                        preconditionFailure()
                    }
                    return colorTable.withUnsafeBufferPointer { colorTableBuffer in
                        guard let colorTableBufferAddress = colorTableBuffer.baseAddress else {
                            os.os_log(.error, "unable to create %@ from %@: indexed color space: missing color table", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                            preconditionFailure()
                        }
                        let colorTableLastIndex = (colorTableBuffer.count / baseColorSpace.numberOfComponents) - 1
                        guard let colorSpace = ColorSpace(indexedBaseSpace: baseColorSpace, last: colorTableLastIndex, colorTable: colorTableBufferAddress) else {
                            os.os_log(.error, "unable to create %@ from %@: indexed color space: incorrect color table", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                            preconditionFailure()
                        }
                        return colorSpace
                    }
                case .pattern:
                    guard let colorSpace = ColorSpace(patternBaseSpace: baseColorSpace) else {
                        os.os_log(.error, "unable to create %@ from %@: pattern color space: incorrect base color space", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                        preconditionFailure()
                    }
                    return colorSpace
                default:
                    os.os_log(.error, "unable to create %@ from %@: unknown color space", String(reflecting: ColorSpace.self), String(reflecting: Self.self))
                    preconditionFailure()
            }
        }
    }
#endif
