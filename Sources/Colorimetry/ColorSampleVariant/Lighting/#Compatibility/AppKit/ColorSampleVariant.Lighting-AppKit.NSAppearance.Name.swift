//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    internal import class AppKit.NSAppearance

    extension ColorSampleVariant.Lighting {

        // MARK: ColorSampleVariant.Lighting - AppKit.NSAppearance.Name

        internal init(for appearanceName: AppKit.NSAppearance.Name) {
            switch appearanceName {
                case
                    .aqua,
                    .vibrantLight,
                    .accessibilityHighContrastAqua,
                    .accessibilityHighContrastVibrantLight
                :
                    self = .light
                case
                    .darkAqua,
                    .vibrantDark,
                    .accessibilityHighContrastDarkAqua,
                    .accessibilityHighContrastVibrantDark
                :
                    self = .dark
                default:
                    self.init()
            }
        }
    }
#endif
