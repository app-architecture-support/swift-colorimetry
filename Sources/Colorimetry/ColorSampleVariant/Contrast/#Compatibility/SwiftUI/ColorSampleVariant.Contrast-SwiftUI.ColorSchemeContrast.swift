//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import enum SwiftUI.ColorSchemeContrast

    extension ColorSampleVariant.Contrast {

        // MARK: ColorSampleVariant.Contrast - SwiftUI.ColorSchemeContrast

        public init(_ colorSchemeContrast: SwiftUI.ColorSchemeContrast) {
            switch colorSchemeContrast {
                case .standard:
                    self = .standard
                case .increased:
                    self = .increased
                @unknown default:
                    self.init()
            }
        }
    }

    extension SwiftUI.ColorSchemeContrast {

        // MARK: SwiftUI.ColorSchemeContrast - ColorSampleVariant.Contrast

        public init(_ colorSampleContrast: ColorSampleVariant.Contrast) {
            self = switch colorSampleContrast {
                case .standard: .standard
                case .increased: .increased
            }
        }
    }
#endif
