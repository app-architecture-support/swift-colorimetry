//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    public import class AppKit.NSColorSpace

    extension ExpressibleByColorSpace
    where Self: AppKit.NSColorSpace {

        // MARK: ExpressibleByColorSpace

        public init(colorSpace: some ColorSpace) {
            self = colorSpace._converting(to: Self.self)
        }
    }

    extension AppKit.NSColorSpace: ExpressibleByColorSpace {
        /* This scope is intentionally left blank. */
    }
#endif
