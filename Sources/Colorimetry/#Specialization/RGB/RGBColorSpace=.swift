//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

#if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
    public import CoreGraphics
    fileprivate import os
#endif

public struct RGBColorSpace: Sendable, Hashable {

    // MARK: RGBColorSpace - Initialization

    public init(
        gamut: Gamut = .displayP3,
        isClamping: Bool = false,
        transferFunction: TransferFunction = .logarithmGamma
    ) {
        self.gamut = gamut
        self.isClamping = isClamping
        self.transferFunction = transferFunction
    }

    // MARK: RGBColorSpace - Representation

    private let gamut: Gamut

    private let isClamping: Bool

    private let transferFunction: TransferFunction
}

extension RGBColorSpace {

    // MARK: RGBColorSpace - Gamut

    public enum Gamut: Sendable, Hashable {

        // MARK: RGBColorSpace.Gamut

        case sRGB

        case displayP3
    }
}

extension RGBColorSpace {

    // MARK: RGBColorSpace - TransferFunction

    /// [Color transfer function](https://en.wikipedia.org/wiki/Transfer_functions_in_imaging)
    public enum TransferFunction: Sendable, Hashable {

        // MARK: RGBColorSpace.TransferFunction

        /// [Linear](https://en.wikipedia.org/wiki/Linear_function_(calculus))
        case linear

        /// [Gamma](https://en.wikipedia.org/wiki/Gamma_correction)
        case gamma

        /// [Hybrid log–gamma](https://en.wikipedia.org/wiki/Hybrid_log-gamma)
        case logarithmGamma

        /// [Perceptual quantizer](https://en.wikipedia.org/wiki/Perceptual_quantizer)
        case perceptualQuantizer
    }
}

extension RGBColorSpace: CustomDebugStringConvertible {

    // MARK: CustomDebugStringConvertible

    public var debugDescription: String {
        var fragmentList: [String] = .init()
        switch gamut {
            case .sRGB: fragmentList.append("sRGB")
            case .displayP3: fragmentList.append("DisplayP3")
        }
        switch transferFunction {
            case .linear:
                if isClamping {
                    fragmentList.append("Li")
                } else {
                    fragmentList.append("ExLi")
                }
            case .gamma: 
                if !isClamping {
                    fragmentList.append("Ex")
                }
            case .logarithmGamma: fragmentList.append("HLG")
            case .perceptualQuantizer: fragmentList.append("PQ")
        }
        return fragmentList.joined(separator: "_")
    }
}

extension RGBColorSpace: ColorSpace {

    // MARK: ColorSpace - Component

    public enum Component: Sendable, Hashable {

        // MARK: RGBColorSpace.Component

        case red

        case green

        case blue
    }

    public var componentCount: Int {
        3
    }

    // MARK: ColorSpace - ComponentIndex

    public func indexForComponent(_ component: Component) -> ComponentIndex {
        switch component {
            case .red: 0
            case .green: 1
            case .blue: 2
        }
    }

    public func componentForIndex(_ componentIndex: ComponentIndex) -> Component {
        switch componentIndex {
            case 0: .red
            case 1: .green
            case 2: .blue
            default: preconditionFailure("unable to determine color component for \(String(reflecting: Self.self)): the index is out of range")
        }
    }

    // MARK: ColorSpace - ComponentIntensity

    public func defaultIntensityForComponent(_ component: Component) -> ComponentIntensity {
        0
    }

    // MARK: ColorSpace - _Converting

    #if os(macOS) || os(tvOS) || os(iOS) || os(watchOS) || os(visionOS)
        @_documentation(visibility: internal)
        public func _converting<ColorSpace: CoreGraphics.CGColorSpace>(to _: ColorSpace.Type) -> ColorSpace {
            let colorSpaceName = switch (gamut, isClamping, transferFunction) {
                case (.sRGB, false, .linear):
                    CoreGraphics.CGColorSpace.extendedLinearSRGB
                case (.sRGB, false, _):
                    CoreGraphics.CGColorSpace.extendedSRGB
                case (.sRGB, true, .linear):
                    CoreGraphics.CGColorSpace.linearSRGB
                case (.sRGB, true, _):
                    CoreGraphics.CGColorSpace.sRGB
                case (.displayP3, false, .linear):
                    CoreGraphics.CGColorSpace.extendedLinearDisplayP3
                case (.displayP3, false, .gamma):
                    if #available(macOS 11.0, tvOS 14.0, iOS 14.0, watchOS 7.0, *) {
                        CoreGraphics.CGColorSpace.extendedDisplayP3
                    } else {
                        CoreGraphics.CGColorSpace.displayP3
                    }
                case (.displayP3, _, .logarithmGamma):
                    CoreGraphics.CGColorSpace.displayP3_HLG
                case (.displayP3, _, .perceptualQuantizer):
                    if #available(macOS 10.15.4, tvOS 13.4, iOS 13.4, watchOS 6.2, *) {
                        CoreGraphics.CGColorSpace.displayP3_PQ
                    } else {
                        CoreGraphics.CGColorSpace.displayP3
                    }
                case (.displayP3, true, .linear):
                    if #available(macOS 12.0, tvOS 15.0, iOS 15.0, watchOS 8.0, *) {
                        CoreGraphics.CGColorSpace.linearDisplayP3
                    } else {
                        CoreGraphics.CGColorSpace.extendedLinearDisplayP3
                    }
                case (.displayP3, true, .gamma):
                    CoreGraphics.CGColorSpace.displayP3
            }
            guard let colorSpace = ColorSpace(name: colorSpaceName) else {
                os.os_log(.error, "unable to create %@ from %@: incorrect color space name: $@", String(reflecting: ColorSpace.self), String(reflecting: Self.self), String(reflecting: colorSpaceName))
                preconditionFailure()
            }
            return colorSpace
        }
    #endif
}
