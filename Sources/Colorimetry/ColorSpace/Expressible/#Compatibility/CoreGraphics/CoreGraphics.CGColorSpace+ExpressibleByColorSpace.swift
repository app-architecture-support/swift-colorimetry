//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class CoreGraphics.CGColorSpace

    extension ExpressibleByColorSpace
    where Self: CoreGraphics.CGColorSpace {

        // MARK: ExpressibleByColorSpace

        public init(colorSpace: some ColorSpace) {
            self = colorSpace._converting(to: Self.self)
        }
    }

    extension CoreGraphics.CGColorSpace: ExpressibleByColorSpace {
        /* This scope is intentionally left blank. */
    }
#endif
