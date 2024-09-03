//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    fileprivate import os

    extension CoreGraphics.CGColor: ColorSample {

        // MARK: ColorSample - Space

        public typealias Space = CoreGraphics.CGColorSpace

        public var space: Space {
            guard let colorSpace else {
                os_log(.error, "unable to get %@ from %@: missing color space", String(reflecting: Space.self), String(reflecting: Self.self))
                preconditionFailure()
            }
            return colorSpace
        }

        // MARK: ColorSample - Component

        public subscript(component component: Component) -> ComponentIntensity? {
            let componentIndex = space.indexForComponent(component)
            guard let components, components.indices.contains(componentIndex) else {
                return nil
            }
            return components[componentIndex]
        }

        // MARK: ColorSample - _Converting

        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            if let color = self as? Color {
                return color
            }
            guard let colorSpace else {
                os.os_log(.error, "unable to create %@ from %@: missing color space", String(reflecting: Color.self), String(reflecting: Self.self))
                return .init(gray: 0, alpha: 0)
            }
            guard let colorComponentList = components else {
                os.os_log(.error, "unable to create %@ from %@: missing color component list", String(reflecting: Color.self), String(reflecting: Self.self))
                return .init(gray: 0, alpha: 0)
            }
            return colorComponentList.withUnsafeBufferPointer { colorComponentListBuffer in
                guard let colorComponentListBufferAddress = colorComponentListBuffer.baseAddress else {
                    os.os_log(.error, "unable to create %@ from %@: missing color component list", String(reflecting: Color.self), String(reflecting: Self.self))
                    return .init(gray: 0, alpha: 0)
                }
                let color = if let pattern {
                    Color(patternSpace: colorSpace, pattern: pattern, components: colorComponentListBufferAddress)
                } else {
                    Color(colorSpace: colorSpace, components: colorComponentListBufferAddress)
                }
                guard let color else {
                    os.os_log(.error, "unable to create %@ from %@: incorrect color space, color pattern, or color component list", String(reflecting: Color.self), String(reflecting: Self.self))
                    return .init(gray: 0, alpha: 0)
                }
                return color
            }
        }
    }
#endif
