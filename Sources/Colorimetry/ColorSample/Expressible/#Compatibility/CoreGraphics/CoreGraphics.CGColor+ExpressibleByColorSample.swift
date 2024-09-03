//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics

    extension ExpressibleByColorSample
    where Self: CoreGraphics.CGColor {

        // MARK: ExpressibleByColorSample

        public init(colorSample: some ColorSample) {
            self = colorSample._converting(to: Self.self)
        }
    }

    extension CoreGraphics.CGColor: ExpressibleByColorSample {
        /* This scope is intentionally left blank. */
    }
#endif
