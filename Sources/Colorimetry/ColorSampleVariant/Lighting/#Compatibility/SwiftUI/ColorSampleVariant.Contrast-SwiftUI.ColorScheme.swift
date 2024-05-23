//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import enum SwiftUI.ColorScheme

    extension ColorSampleVariant.Lighting {

        // MARK: ColorSampleVariant.Lighting - SwiftUI.ColorScheme

        public init(_ colorScheme: SwiftUI.ColorScheme) {
            switch colorScheme {
                case .light:
                    self = .light
                case .dark:
                    self = .dark
                @unknown default:
                    self.init()
            }
        }
    }

    extension SwiftUI.ColorScheme {

        // MARK: SwiftUI.ColorScheme - ColorSampleVariant.Lighting

        public init(_ colorSampleLighting: ColorSampleVariant.Lighting) {
            self = switch colorSampleLighting {
                case .light: .light
                case .dark: .dark
            }
        }
    }
#endif
