//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import SwiftUI

    @available(macOS 14.0, tvOS 17.0, iOS 17.0, watchOS 10.0, *)
    extension SwiftUI.Color.Resolved: ExpressibleByColorSample {

        // MARK: ExpressibleByColorSample

        public init(colorSample: some ColorSample) {
            self = colorSample._converting(to: Self.self)
        }
    }
#endif
