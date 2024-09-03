//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import SwiftUI

    extension SwiftUI.Color: ExpressibleByColorVaryingSample {

        // MARK: ExpressibleByColorVaryingSample

        public init(colorVaryingSample: some ColorVaryingSample) {
            self = colorVaryingSample._converting(to: Self.self)
        }
    }
#endif
