//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import class UIKit.UIColor

    extension ExpressibleByColorVaryingSample
    where Self: UIKit.UIColor {

        // MARK: ExpressibleByColorVaryingSample

        public init(colorVaryingSample: some ColorVaryingSample) {
            self = colorVaryingSample._converting(to: Self.self)
        }
    }

    extension UIKit.UIColor: ExpressibleByColorVaryingSample {
        /* This scope is intentionally left blank. */
    }
#endif
