//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import SwiftUI

    extension SwiftUI.EnvironmentValues {

        // MARK: SwiftUI.EnvironmentValues - ColorSampleVariant

        public var colorSampleVariant: ColorSampleVariant {

            get {
                .init(
                    lighting: .init(colorScheme),
                    contrast: .init(colorSchemeContrast)
                )
            }

            set(colorSampleVariant) {
                colorScheme = .init(colorSampleVariant.lighting)
                #if false /* SwiftUI does not currently support customizing this color contrast */
                    colorSchemeContrast = .init(colorSampleVariant.contrast)
                #endif
            }
        }
    }
#endif
