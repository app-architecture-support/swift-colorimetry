//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

public struct RGBColorSample: Sendable, Hashable, ColorSample {

    // MARK: RGBColorSample - Initialization

    private init(componentStorage: ComponentStorage, space: Space) {
        self.componentStorage = componentStorage
        self.space = space
    }

    public init(
        _ red: ComponentIntensity,
        _ green: ComponentIntensity,
        _ blue: ComponentIntensity,
        in space: Space = .init()
    ) {
        self.init(componentStorage: [red, green, blue], space: space)
    }

    // MARK: RGBColorSample - Representation

    private typealias ComponentStorage = SIMD3<ComponentIntensity>

    private var componentStorage: ComponentStorage

    // MARK: ColorSample - Initialization

    public init() {
        self.init(componentStorage: .init(), space: .init())
    }

    // MARK: ColorSample - Space

    public typealias Space = RGBColorSpace

    public let space: Space

    // MARK: ColorSample - Component

    public subscript(component component: Component) -> ComponentIntensity? {
        let componentIndex = space.indexForComponent(component)
        guard componentStorage.indices.contains(componentIndex) else {
            return nil
        }
        return componentStorage[componentIndex]
    }
}

extension RGBColorSample: CustomDebugStringConvertible {

    // MARK: CustomDebugStringConvertible

    public var debugDescription: String {
        return "RGB("
            + componentList.lazy.map { String(reflecting: $0) }.joined(separator: ", ")
            + ", in: "
            + String(reflecting: space)
            + ")"
    }
}
