//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class CoreGraphics.CGColor
    public import class CoreGraphics.CGColorSpace
    public import struct SwiftUI.Color

    @available(macOS 14.0, tvOS 17.0, iOS 17.0, watchOS 10.0, *)
    extension SwiftUI.Color.Resolved: ColorSample {

        public typealias Space = CoreGraphics.CGColorSpace

        public var space: Space {
            cgColor.space
        }

        // MARK: ColorSample - Component

        public subscript(component component: Component) -> ComponentIntensity? {
            cgColor[component: component]
        }

        // MARK: ColorSample - Initialization

        public init() {
            self.init(red: 0, green: 0, blue: 0)
        }

        // MARK: ColorSample - _Converting

        @_documentation(visibility: internal)
        public func _converting<Color: CoreGraphics.CGColor>(to _: Color.Type) -> Color {
            cgColor._converting(to: Color.self)
        }

        @_documentation(visibility: internal)
        public func _converting(to _: SwiftUI.Color.Resolved.Type) -> SwiftUI.Color.Resolved {
            self
        }
    }
#endif
