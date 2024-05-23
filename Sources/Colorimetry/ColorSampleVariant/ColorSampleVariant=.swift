//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

public struct ColorSampleVariant: Sendable, Hashable {

    // MARK: ColorSampleVariant - Initialization

    public init(lighting: Lighting = .init(), contrast: Contrast = .init()) {
        self.lighting = lighting
        self.contrast = contrast
    }

    // MARK: ColorSampleVariant - Representation

    public var lighting: Lighting

    public var contrast: Contrast
}
