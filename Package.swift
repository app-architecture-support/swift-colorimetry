// swift-tools-version: 5.10

//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import PackageDescription

internal let package = Package(
    name: "swift-colorimetry",
    platforms: [
        .macOS(.v10_15),
        .tvOS(.v13),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Colorimetry",
            targets: ["Colorimetry"]
        )
    ],
    targets: [
        .target(
            name: "Colorimetry",
            swiftSettings: .robust
        )
    ]
)

extension [SwiftSetting] {

    // MARK: [SwiftSetting] - Robust
    
    public static let robust: Self
        = .robustTypeSystem
        + .robustConcurrency

    public static let robustTypeSystem: Self = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableExperimentalFeature("AccessLevelOnImport"),
    ]

    public static let robustConcurrency: Self = [
        .enableExperimentalFeature("StrictConcurrency")
    ]
}
