//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS)
    public import class AppKit.NSColor

    extension ExpressibleByColorVaryingSample
    where Self: AppKit.NSColor {

        // MARK: ExpressibleByColorVaryingSample

        public init(colorVaryingSample: some ColorVaryingSample) {
            self = colorVaryingSample._converting(to: Self.self)
        }
    }

    extension AppKit.NSColor: ExpressibleByColorVaryingSample {
        /* This scope is intentionally left blank. */
    }
#endif
