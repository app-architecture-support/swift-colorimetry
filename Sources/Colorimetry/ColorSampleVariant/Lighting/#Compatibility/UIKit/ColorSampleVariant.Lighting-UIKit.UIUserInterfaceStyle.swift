//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(visionOS)
    public import UIKit

    extension ColorSampleVariant.Lighting {

        // MARK: ColorSampleVariant.Lighting - UIKit.UIUserInterfaceStyle

        public init(_ userInterfaceStyle: UIKit.UIUserInterfaceStyle) {
            switch userInterfaceStyle {
                case .light:
                    self = .light
                case .dark:
                    self = .dark
                case .unspecified:
                    fallthrough
                @unknown default:
                    self.init()
            }
        }
    }

    extension UIKit.UIUserInterfaceStyle {

        // MARK: UIKit.UIUserInterfaceStyle - ColorSampleVariant.Lighting

        public init(_ colorSampleLighting: ColorSampleVariant.Lighting) {
            self = switch colorSampleLighting {
                case .light: .light
                case .dark: .dark
            }
        }
    }
#endif
