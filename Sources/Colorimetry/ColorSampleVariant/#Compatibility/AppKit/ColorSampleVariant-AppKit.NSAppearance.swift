//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    public import AppKit
    fileprivate import os

    extension AppKit.NSAppearance {

        // MARK: AppKit.NSAppearance - ColorSampleVariant

        public convenience init(colorSampleVariant: ColorSampleVariant) {
            self.init(_colorSampleVariant: colorSampleVariant)
        }

        public var colorSampleVariant: ColorSampleVariant {
            let appearanceName = bestMatch(
                from: [
                    .aqua,
                    .darkAqua,
                    .vibrantLight,
                    .vibrantDark,
                    .accessibilityHighContrastAqua,
                    .accessibilityHighContrastDarkAqua,
                    .accessibilityHighContrastVibrantLight,
                    .accessibilityHighContrastVibrantDark
                ]
            )
            return if let appearanceName {
                .init(for: appearanceName)
            } else {
                .init()
            }
        }
    }

    fileprivate protocol _AppKit_NSAppearance {
        /* This scope is intentionally left blank. */
    }

    extension _AppKit_NSAppearance
    where Self: AppKit.NSAppearance {

        // MARK: _AppKit_NSAppearance - Initialization

        fileprivate init(_colorSampleVariant colorSampleVariant: ColorSampleVariant) {
            if let maybeSelf = Self(named: .init(for: colorSampleVariant)) {
                self = maybeSelf
            } else {
                os.os_log(.error, "unable to create $@ from $@", String(reflecting: Self.self), String(reflecting: ColorSampleVariant.self))
                self.init()
            }
        }
    }

    extension AppKit.NSAppearance: _AppKit_NSAppearance {
        /* This scope is intentionally left blank. */
    }

#endif
