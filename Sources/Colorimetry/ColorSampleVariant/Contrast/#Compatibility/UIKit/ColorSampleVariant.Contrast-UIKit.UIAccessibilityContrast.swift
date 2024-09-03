//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(visionOS)
    public import UIKit

    extension ColorSampleVariant.Contrast {

        // MARK: ColorSampleVariant.Contrast - UIKit.UIUserInterfaceStyle

        public init(_ accessibilityContrast: UIKit.UIAccessibilityContrast) {
            switch accessibilityContrast {
                case .normal:
                    self = .standard
                case .high:
                    self = .increased
                case .unspecified:
                    fallthrough
                @unknown default:
                    self.init()
            }
        }
    }

    extension UIKit.UIAccessibilityContrast {

        // MARK: UIKit.UIAccessibilityContrast - ColorSampleVariant.Contrast

        public init(_ colorSampleContrast: ColorSampleVariant.Contrast) {
            self = switch colorSampleContrast {
                case .standard: .normal
                case .increased: .high
            }
        }
    }
#endif
