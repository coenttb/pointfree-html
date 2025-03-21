//
//  HTMLInlineStyle.swift
//
//
//  Created by Point-Free, Inc
//

import ConcurrencyExtras
import Dependencies
import Foundation
import OrderedCollections

/// Extension to add inline styling capabilities to all HTML elements.
extension HTML {
    /// Applies a CSS style property to an HTML element.
    ///
    /// This method enables a type-safe, declarative approach to styling HTML elements
    /// directly in Swift code. It generates CSS classes and stylesheets automatically.
    ///
    /// Example:
    /// ```swift
    /// div {
    ///     "Hello, World!"
    /// }
    /// .inlineStyle("color", "red")
    /// .inlineStyle("font-weight", "bold", pseudo: .hover)
    /// ```
    ///
    /// - Parameters:
    ///   - property: The CSS property name (e.g., "color", "margin", "font-size").
    ///   - value: The value for the CSS property. Pass nil to omit this style.
    ///   - mediaQuery: Optional media query to apply this style conditionally.
    ///   - pre: Optional selector prefix for more complex CSS selectors.
    ///   - pseudo: Optional pseudo-class or pseudo-element to apply (e.g., `:hover`, `::before`).
    /// - Returns: An HTML element with the specified style applied.
    public func inlineStyle(
        _ property: String,
        _ value: String?,
        media mediaQuery: MediaQuery? = nil,
        pre: String? = nil,
        pseudo: Pseudo? = nil
    ) -> HTMLInlineStyle<Self> {
        HTMLInlineStyle(
            content: self,
            property: property,
            value: value,
            mediaQuery: mediaQuery,
            pre: pre,
            pseudo: pseudo
        )
    }
}

/// A wrapper that applies CSS styles to an HTML element.
///
/// `HTMLInlineStyle` applies CSS styles to HTML elements by generating
/// unique class names and collecting the associated styles in a stylesheet.
/// This approach allows for efficient CSS generation and prevents duplication
/// of styles across multiple elements.
///
/// You typically don't create this type directly but use the `inlineStyle` method
/// on HTML elements.
///
/// Example:
/// ```swift
/// div {
///     p { "Styled text" }
///         .inlineStyle("color", "blue")
///         .inlineStyle("margin", "1rem")
/// }
/// ```
public struct HTMLInlineStyle<Content: HTML>: HTML {
    /// The HTML content being styled.
    private let content: Content
    
    /// The collection of styles to apply.
    private var styles: [Style]
    
    /// Generator for unique class names based on styles.
    @Dependency(ClassNameGenerator.self) fileprivate var classNameGenerator
    
    /// Creates a new styled HTML element.
    ///
    /// - Parameters:
    ///   - content: The HTML element to style.
    ///   - property: The CSS property name.
    ///   - value: The value for the CSS property.
    ///   - mediaQuery: Optional media query for conditional styling.
    ///   - pre: Optional selector prefix.
    ///   - pseudo: Optional pseudo-class or pseudo-element.
    init(
        content: Content,
        property: String,
        value: String?,
        mediaQuery: MediaQuery?,
        pre: String? = nil,
        pseudo: Pseudo?
    ) {
        self.content = content
        self.styles =
        value.map {
            [
                Style(
                    property: property,
                    value: $0,
                    media: mediaQuery,
                    preSelector: pre,
                    pseudo: pseudo
                )
            ]
        }
        ?? []
    }
    
    /// Adds an additional style to this element.
    ///
    /// This method allows for chaining multiple styles on a single element.
    ///
    /// Example:
    /// ```swift
    /// div { "Content" }
    ///     .inlineStyle("color", "blue")
    ///     .inlineStyle("font-size", "16px")
    /// ```
    ///
    /// - Parameters:
    ///   - property: The CSS property name.
    ///   - value: The value for the CSS property.
    ///   - mediaQuery: Optional media query for conditional styling.
    ///   - pre: Optional selector prefix.
    ///   - pseudo: Optional pseudo-class or pseudo-element.
    /// - Returns: An HTML element with both the original and new styles applied.
    public func inlineStyle(
        _ property: String,
        _ value: String?,
        media mediaQuery: MediaQuery? = nil,
        pre: String? = nil,
        pseudo: Pseudo? = nil
    ) -> HTMLInlineStyle {
        var copy = self
        if let value {
            copy.styles.append(
                Style(
                    property: property,
                    value: value,
                    media: mediaQuery,
                    preSelector: pre,
                    pseudo: pseudo
                )
            )
        }
        return copy
    }
    
    /// Renders this styled HTML element into the provided printer.
    ///
    /// This method:
    /// 1. Saves the current class attribute
    /// 2. Generates unique class names for each style
    /// 3. Adds the styles to the printer's stylesheet
    /// 4. Adds the class names to the element's class attribute
    /// 5. Renders the content
    /// 6. Restores the original class attribute
    ///
    /// - Parameters:
    ///   - html: The styled HTML element to render.
    ///   - printer: The printer to render the HTML into.
    public static func _render(_ html: HTMLInlineStyle<Content>, into printer: inout HTMLPrinter) {
        let previousClass = printer.attributes["class"]  // TODO: should we optimize this?
        defer {
            Content._render(html.content, into: &printer)
            printer.attributes["class"] = previousClass
        }
        
        for style in html.styles {
            let className = html.classNameGenerator.generate(style)
            let selector = """
        \(style.preSelector.map { "\($0) " } ?? "").\(className)\(style.pseudo?.rawValue ?? "")
        """
            
            if printer.styles[style.media, default: [:]][selector] == nil {
                printer.styles[style.media, default: [:]][selector] = "\(style.property):\(style.value)"
            }
            printer
                .attributes["class", default: ""]
                .append(printer.attributes.keys.contains("class") ? " \(className)" : className)
        }
    }
    
    /// This type uses direct rendering and doesn't have a body.
    public var body: Never { fatalError() }
}

private struct ClassNameGenerator: DependencyKey {
    var generate: @Sendable (Style) -> String
    
    static var liveValue: ClassNameGenerator {
        let seenStyles = LockIsolated<OrderedSet<Style>>([])
        return Self { style in
            seenStyles.withValue { seenStyles in
                let index =
                seenStyles.firstIndex(of: style)
                ?? {
                    seenStyles.append(style)
                    return seenStyles.count - 1
                }()
#if DEBUG
                return "\(style.property)-\(index)"
#else
                return "c\(index)"
#endif
            }
        }
    }
    
    static var testValue: ClassNameGenerator {
        Self { style in
            let hash = classID(
                style.value
                + (style.media?.rawValue ?? "")
                + (style.preSelector ?? "")
                + (style.pseudo?.rawValue ?? "")
            )
            return "\(style.property)-\(hash)"
        }
    }
}

private struct Style: Hashable, Sendable {
    let property: String
    let value: String
    let media: MediaQuery?
    let preSelector: String?
    let pseudo: Pseudo?
}

/// Represents a CSS media query for conditional styling.
///
/// `MediaQuery` allows you to apply styles conditionally based on
/// device characteristics or user preferences.
///
/// Example:
/// ```swift
/// div { "Dark mode text" }
///     .inlineStyle("color", "white", media: .dark)
/// ```
///
/// You can use the predefined media queries or create custom ones.
public struct MediaQuery: RawRepresentable, Hashable, Sendable {
    /// Creates a media query with the specified CSS media query string.
    ///
    /// - Parameter rawValue: The CSS media query string.
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    /// The CSS media query string.
    public var rawValue: String
}

/// Predefined common media queries.
extension MediaQuery {
    /// Targets devices in dark mode.
    public static let dark = Self(rawValue: "(prefers-color-scheme: dark)")
    
    /// Targets print media (when the page is being printed).
    public static let print = Self(rawValue: "print")
}

/// Represents CSS pseudo-classes and pseudo-elements.
///
/// `Pseudo` allows you to apply styles to elements in specific states
/// or to target specific parts of elements.
///
/// Example:
/// ```swift
/// button { "Hover me" }
///     .inlineStyle("background-color", "blue")
///     .inlineStyle("background-color", "red", pseudo: .hover)
/// ```
public struct Pseudo: RawRepresentable, Hashable, Sendable {
    /// The CSS pseudo-class or pseudo-element selector.
    public var rawValue: String
    
    /// Creates a pseudo-selector with the specified CSS selector string.
    ///
    /// - Parameter rawValue: The CSS pseudo-selector string.
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static let active = Self(rawValue: ":active")
    public static let after = Self(rawValue: "::after")
    public static let before = Self(rawValue: "::before")
    public static let checked = Self(rawValue: ":checked")
    public static let disabled = Self(rawValue: ":disabled")
    public static let empty = Self(rawValue: ":empty")
    public static let enabled = Self(rawValue: ":enabled")
    public static let firstChild = Self(rawValue: ":first-child")
    public static let firstOfType = Self(rawValue: ":first-of-type")
    public static let focus = Self(rawValue: ":focus")
    public static let hover = Self(rawValue: ":hover")
    public static let inRange = Self(rawValue: ":in-range")
    public static let invalid = Self(rawValue: ":invalid")
    public static func `is`(_ s: String) -> Self { Self(rawValue: ":is(\(s))") }
    public static let lang = Self(rawValue: ":lang")
    public static let lastChild = Self(rawValue: ":last-child")
    public static let lastOfType = Self(rawValue: ":last-of-type")
    public static let link = Self(rawValue: ":link")
    public static func nthChild(_ n: String) -> Self { Self(rawValue: ":nth-child(\(n))") }
    public static func nthLastChild(_ n: String) -> Self { Self(rawValue: ":nth-last-child(\(n))") }
    public static func nthLastOfType(_ n: String) -> Self {
        Self(rawValue: ":nth-last-of-type(\(n))")
    }
    public static func nthOfType(_ n: String) -> Self { Self(rawValue: ":nth-of-type(\(n))") }
    public static let onlyChild = Self(rawValue: ":only-child")
    public static let onlyOfType = Self(rawValue: ":only-of-type")
    public static let optional = Self(rawValue: ":optional")
    public static let outOfRange = Self(rawValue: ":out-of-range")
    public static let readOnly = Self(rawValue: ":read-only")
    public static let readWrite = Self(rawValue: ":read-write")
    public static let required = Self(rawValue: ":required")
    public static let root = Self(rawValue: ":root")
    public static let target = Self(rawValue: ":target")
    public static let valid = Self(rawValue: ":valid")
    public static let visited = Self(rawValue: ":visited")
    public static func not(_ other: Self) -> Self { Self(rawValue: ":not(\(other.rawValue))") }
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(rawValue: lhs.rawValue + rhs.rawValue)
    }
}

private func classID(_ value: String) -> String {
    return encode(murmurHash(value))
    
    func encode(_ value: UInt32) -> String {
        guard value > 0
        else { return "" }
        var number = value
        var encoded = ""
        encoded.reserveCapacity(Int(log(Double(number)) / log(64)) + 1)
        while number > 0 {
            let index = Int(number % baseCount)
            number /= baseCount
            encoded.append(baseChars[index])
        }
        
        return encoded
    }
    func murmurHash(_ string: String) -> UInt32 {
        let data = [UInt8](string.utf8)
        let length = data.count
        let c1: UInt32 = 0xcc9e_2d51
        let c2: UInt32 = 0x1b87_3593
        let r1: UInt32 = 15
        let r2: UInt32 = 13
        let m: UInt32 = 5
        let n: UInt32 = 0xe654_6b64
        
        var hash: UInt32 = 0
        
        let chunkSize = MemoryLayout<UInt32>.size
        let chunks = length / chunkSize
        
        for i in 0..<chunks {
            var k: UInt32 = 0
            let offset = i * chunkSize
            
            for j in 0..<chunkSize {
                k |= UInt32(data[offset + j]) << (j * 8)
            }
            
            k &*= c1
            k = (k << r1) | (k >> (32 - r1))
            k &*= c2
            
            hash ^= k
            hash = (hash << r2) | (hash >> (32 - r2))
            hash = hash &* m &+ n
        }
        
        var k1: UInt32 = 0
        let tailStart = chunks * chunkSize
        
        switch length & 3 {
        case 3:
            k1 ^= UInt32(data[tailStart + 2]) << 16
            fallthrough
        case 2:
            k1 ^= UInt32(data[tailStart + 1]) << 8
            fallthrough
        case 1:
            k1 ^= UInt32(data[tailStart])
            k1 &*= c1
            k1 = (k1 << r1) | (k1 >> (32 - r1))
            k1 &*= c2
            hash ^= k1
        default:
            break
        }
        
        hash ^= UInt32(length)
        hash ^= (hash >> 16)
        hash &*= 0x85eb_ca6b
        hash ^= (hash >> 13)
        hash &*= 0xc2b2_ae35
        hash ^= (hash >> 16)
        
        return hash
    }
}
private let baseChars = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
private let baseCount = UInt32(baseChars.count)


