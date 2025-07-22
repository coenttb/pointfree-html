// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension String {
    static let pointfreeHTML: Self = "PointFreeHTML"
    static let pointfreeHTMLElements: Self = "PointFreeHTMLElements"
    static let pointfreeHTMLTestSupport: Self = "PointFreeHTMLTestSupport"
}

extension Target.Dependency {
    static var pointfreeHTML: Self { .target(name: .pointfreeHTML) }
    static var pointfreeHTMLElements: Self { .target(name: .pointfreeHTMLElements) }
    static var pointfreeHTMLTestSupport: Self { .target(name: .pointfreeHTMLTestSupport) }
}

extension Target.Dependency {
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var inlineSnapshotTesting: Self { .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing") }
}

let package = Package(
    name: "pointfree-html",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .macCatalyst(.v17)
    ],
    products: [
        .library(name: .pointfreeHTML, targets: [.pointfreeHTML]),
        .library(name: .pointfreeHTMLElements, targets: [.pointfreeHTMLElements]),
        .library(name: .pointfreeHTMLTestSupport, targets: [.pointfreeHTMLTestSupport])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.3.5"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.18.3")
    ],
    targets: [
        .target(
            name: .pointfreeHTML,
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "OrderedCollections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: .pointfreeHTML.tests,
            dependencies: [
                .pointfreeHTML,
                .pointfreeHTMLTestSupport
            ]
        ),
        .target(
            name: .pointfreeHTMLElements,
            dependencies: [
                .pointfreeHTML
            ]
        ),
        .testTarget(
            name: .pointfreeHTMLElements.tests,
            dependencies: [
                .pointfreeHTMLElements,
                .pointfreeHTMLTestSupport
            ]
        ),
        .target(
            name: .pointfreeHTMLTestSupport,
            dependencies: [
                .pointfreeHTML,
                .inlineSnapshotTesting,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)

extension String {
    var tests: Self {
        "\(self) Tests"
    }
}
