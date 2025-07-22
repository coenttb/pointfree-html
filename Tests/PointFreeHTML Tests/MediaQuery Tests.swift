//
//  MediaQueryTests.swift
//  pointfree-html
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import Foundation
import PointFreeHTML
import Testing

@Suite("MediaQuery Tests")
struct MediaQueryTests {

    @Test("MediaQuery basic creation")
    func mediaQueryBasicCreation() throws {
        let mediaQuery = MediaQuery(rawValue: "screen and (max-width: 768px)")

        // Test that media query can be created
        #expect(mediaQuery.rawValue == "screen and (max-width: 768px)")
    }

    @Test("MediaQuery with different conditions")
    func mediaQueryWithDifferentConditions() throws {
        let mobileQuery = MediaQuery(rawValue: "screen and (max-width: 480px)")
        let tabletQuery = MediaQuery(rawValue: "screen and (min-width: 481px) and (max-width: 1024px)")
        let desktopQuery = MediaQuery(rawValue: "screen and (min-width: 1025px)")

        #expect(mobileQuery.rawValue.contains("max-width: 480px"))
        #expect(tabletQuery.rawValue.contains("min-width: 481px"))
        #expect(desktopQuery.rawValue.contains("min-width: 1025px"))
    }

    @Test("MediaQuery with print media")
    func mediaQueryWithPrintMedia() throws {
        let printQuery = MediaQuery(rawValue: "print")

        #expect(printQuery.rawValue == "print")
    }

    @Test("MediaQuery with orientation")
    func mediaQueryWithOrientation() throws {
        let portraitQuery = MediaQuery(rawValue: "screen and (orientation: portrait)")
        let landscapeQuery = MediaQuery(rawValue: "screen and (orientation: landscape)")

        #expect(portraitQuery.rawValue.contains("portrait"))
        #expect(landscapeQuery.rawValue.contains("landscape"))
    }

    @Test("MediaQuery with device features")
    func mediaQueryWithDeviceFeatures() throws {
        let retinaQuery = MediaQuery(rawValue: "screen and (-webkit-min-device-pixel-ratio: 2)")
        let hoverQuery = MediaQuery(rawValue: "screen and (hover: hover)")

        #expect(retinaQuery.rawValue.contains("device-pixel-ratio"))
        #expect(hoverQuery.rawValue.contains("hover: hover"))
    }

    @Test("MediaQuery equality")
    func mediaQueryEquality() throws {
        let query1 = MediaQuery(rawValue: "screen and (max-width: 768px)")
        let query2 = MediaQuery(rawValue: "screen and (max-width: 768px)")
        let query3 = MediaQuery(rawValue: "screen and (max-width: 1024px)")

        #expect(query1.rawValue == query2.rawValue)
        #expect(query1.rawValue != query3.rawValue)
    }
}
