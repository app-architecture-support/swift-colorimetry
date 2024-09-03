//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(visionOS)
    public import UIKit

    @available(tvOS 17.0, iOS 17.0, *)
    extension UIKit.UIMutableTraits {

        // MARK: UIKit.UIMutableTraits - ColorSampleVariant

        public var colorSampleVariant: ColorSampleVariant {

            get {
                .init(
                    lighting: .init(userInterfaceStyle),
                    contrast: .init(accessibilityContrast)
                )
            }

            set(colorSampleVariant) {
                userInterfaceStyle = .init(colorSampleVariant.lighting)
                accessibilityContrast = .init(colorSampleVariant.contrast)
            }
        }
    }
#endif
