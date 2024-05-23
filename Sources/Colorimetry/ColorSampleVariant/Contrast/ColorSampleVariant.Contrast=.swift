//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

extension ColorSampleVariant {

    // MARK: ColorSampleVariant - Contrast

    public enum Contrast: Sendable, Hashable {

        // MARK: ColorSampleVariant.Contrast

        case standard

        case increased
    }
}

extension ColorSampleVariant.Contrast {

    // MARK: ColorSampleVariant.Lighting - Initialization

    public init() {
        self = .standard
    }
}
