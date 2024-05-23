//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

public typealias RGBAColorSample = OpacitySupportingColorSample<RGBColorSample>

extension RGBAColorSample {

    // MARK: RGBAColorSample - Initialization

    public init(
        _ red: ComponentIntensity,
        _ green: ComponentIntensity,
        _ blue: ComponentIntensity,
        at opacity: ComponentIntensity? = nil,
        in space: ColorSampleType.Space = .init()
    ) {
        self.init(colorSample: .init(red, green, blue, in: space), opacity: opacity)
    }
}
