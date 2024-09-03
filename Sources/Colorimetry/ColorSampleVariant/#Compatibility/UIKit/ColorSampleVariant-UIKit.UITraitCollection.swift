//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(visionOS)
    public import UIKit

    extension UIKit.UITraitCollection {

        // MARK: UIKit.UITraitCollection - ColorSampleVariant

        public convenience init(colorSampleVariant: ColorSampleVariant) {
            if #available(tvOS 17.0, iOS 17.0, *) {
                self.init { mutableTraits in
                    mutableTraits.colorSampleVariant = colorSampleVariant
                }
            } else {
                self.init(
                    traitsFrom: [
                        .init(userInterfaceStyle: .init(colorSampleVariant.lighting)),
                        .init(accessibilityContrast: .init(colorSampleVariant.contrast))
                    ]
                )
            }
        }

        public var colorSampleVariant: ColorSampleVariant {
            .init(
                lighting: .init(userInterfaceStyle),
                contrast: .init(accessibilityContrast)
            )
        }
    }
#endif
