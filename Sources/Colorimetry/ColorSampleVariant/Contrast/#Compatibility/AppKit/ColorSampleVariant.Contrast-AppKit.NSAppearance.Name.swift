//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    internal import class AppKit.NSAppearance

    extension ColorSampleVariant.Contrast {

        // MARK: ColorSampleVariant.Contrast - AppKit.NSAppearance.Name

        internal init(for appearanceName: AppKit.NSAppearance.Name) {
            switch appearanceName {
                case
                    .aqua,
                    .vibrantLight,
                    .darkAqua,
                    .vibrantDark
                :
                    self = .standard
                case
                    .accessibilityHighContrastAqua,
                    .accessibilityHighContrastVibrantLight,
                    .accessibilityHighContrastDarkAqua,
                    .accessibilityHighContrastVibrantDark
                :
                    self = .increased
                default:
                    self.init()
            }
        }
    }
#endif
