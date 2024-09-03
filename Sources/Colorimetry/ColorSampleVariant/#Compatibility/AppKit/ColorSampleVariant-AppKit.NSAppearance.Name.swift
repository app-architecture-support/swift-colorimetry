//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    internal import AppKit

    extension ColorSampleVariant {

        // MARK: ColorSampleVariant - AppKit.NSAppearance.Name

        internal init(for appearanceName: AppKit.NSAppearance.Name) {
            self.init(
                lighting: .init(for: appearanceName),
                contrast: .init(for: appearanceName)
            )
        }
    }

    extension AppKit.NSAppearance.Name {

        // MARK: AppKit.NSAppearance.Name - ColorSampleVariant

        internal init(for colorSampleVariant: ColorSampleVariant) {
            self = switch (colorSampleVariant.lighting, colorSampleVariant.contrast) {
                case (.light, .standard): .aqua
                case (.light, .increased): .accessibilityHighContrastAqua
                case (.dark, .standard): .darkAqua
                case (.dark, .increased): .accessibilityHighContrastDarkAqua
            }
        }
    }
#endif
