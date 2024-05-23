//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

extension ColorSampleVariant {

    // MARK: ColorSampleVariant - Lighting

    public enum Lighting: Sendable, Hashable {

        // MARK: ColorSampleVariant.Lighting

        case light

        case dark
    }
}

extension ColorSampleVariant.Lighting {

    // MARK: ColorSampleVariant.Lighting - Initialization

    public init() {
        self = .light
    }
}
