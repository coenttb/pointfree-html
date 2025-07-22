# PointFreeHTML

A Swift package to renders any Swift type as HTML on Apple-platforms, Linux, and Windows.

## Overview

PointFreeHTML is a foundational Swift package that enables **any Swift type** to be rendered as HTML through a simple protocol conformance. Other libraries use it to render their types to HTML, like this:

### No child storage
```swift
struct CustomLineBreak: HTML {
  tag("br")
    .inlineStyle("color", "red")
}

let htmlDocument = HTMLDocument {
  CustomLineBreak()
}
``` 

`htmlDocument` can now render either to bytes (`ContiguousArray<UInt8>`) via the `HTMLDocument.render` method, or as a string by passing it to `String.init(_ html: some HTML, encoding: String.Encoding = .utf8) throws`.

### Child storage  

```swift
struct Anchor {
  let href: String
}

extension Anchor {
  public func callAsFunction(
    @HTMLBuilder _ content: () -> some HTML
  ) -> some HTML {
    tag("a") { content() }
  }
}

HTMLDocument {
  Anchor(href: "#") { HTMLText("Click here to go home") }
}

``` 

## Key features

- **Universal HTML Protocol**: Any Swift type can be rendered as HTML by conforming to the `HTML` protocol
- **Declarative Syntax**: SwiftUI-like syntax with `@HTMLBuilder` result builder
- **Type Safety**: Compile-time checking prevents malformed HTML
- **Composable Components**: Build complex UIs from reusable components
- **Minimal Dependencies**: Core library has minimal external dependencies
- **Performance Focused**: Efficient rendering with HTMLPrinter

## Usage examples

For comprehensive examples of building HTML elements and components, see [swift-html](https://github.com/coenttb/swift-html), which provides a complete developer experience built on top of PointFreeHTML.

### Basic protocol conformance

```swift
struct CustomComponent<Content: HTML>: HTML {
    let title: String
    let content: Content
    
    init(
        title: String,
        @HTMLBuilder _ content: () -> Content 
    ) {
        self.title = title
        self.content = content
    }
    
    var body: some HTML {
        div {
            h1 { title }
            content
            p { "Custom component rendered with PointFreeHTML" }
        }
    }
}

CustomComponent(
    title: "Hello World"
) {
    h5 { "This is my custom component" }
}
```

### Integration example

See [swift-html-css-pointfree](https://github.com/coenttb/swift-html-css-pointfree) for an example of how third-party libraries can integrate PointFreeHTML as their rendering engine.

## Integration with Swift Ecosystem

PointFreeHTML integrates seamlessly with the broader Swift web development ecosystem:

### Swift-HTML Integration

[swift-html](https://github.com/coenttb/swift-html) builds on PointFreeHTML to provide domain-accurate HTML and CSS integration and additional convenience APIs:

```swift
import HTML // This imports swift-html which includes PointFreeHTML

struct StyledComponent: HTML {
    var body: some HTML {
        div {
            a(href: "#") { "Styled Heading" }
                .color(.blue)
                .fontSize(.px(24))
                .marginBottom(.px(16))
        }
    }
}
```

### Server Integration

PointFreeHTML works with Swift server frameworks like Vapor:

```swift
import Vapor
import PointFreeHTML

app.get("hello", ":name") { req -> String in
    let name = req.parameters.get("name") ?? "World"
    
    struct Greeting: HTML {
        let name: String
        var body: some HTML {
            h1 { "Hello, \(name)!" }
        }
    }
    
    return try String(Greeting(name: name))
}
```

## Installation

### Swift Package Manager

Add PointFreeHTML to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/pointfree-html", branch: "main")
]
```

### Xcode Project

Add the package dependency in Xcode:
- File → Add Package Dependencies
- Enter: `https://github.com/coenttb/pointfree-html`


## Testing

PointFreeHTML includes support for snapshot testing:

```swift
import PointFreeHTMLTestSupport

@Test
func testMyComponent() {
    let component = MyComponent(title: "Test")
    
    assertInlineSnapshot(of: component, as: .html) {
        """
        <div>
          <h1>Test</h1>
        </div>
        """
    }
}
```

## Real-World Usage

PointFreeHTML powers production applications:

- **[coenttb.com](https://coenttb.com)**: Personal website built entirely with PointFreeHTML
- **[coenttb-com-server](https://github.com/coenttb/coenttb-com-server)**: Open-source backend demonstrating full-stack Swift

## Related Projects

PointFreeHTML is part of a comprehensive Swift web development ecosystem:

### Core Libraries
- [swift-html](https://github.com/coenttb/swift-html): Type-safe HTML & CSS DSL built on PointFreeHTML -** use this for examples and full developer experience**
- [swift-html-css-pointfree](https://github.com/coenttb/swift-html-css-pointfree): Integration layer combining PointFreeHTML with CSS types - **use this as example for third-party library integration**
- [swift-html-types](https://github.com/coenttb/swift-html-types): Complete Swift domain model of HTML elements and attributes  
- [swift-css-types](https://github.com/coenttb/swift-css-types): Complete Swift domain model of CSS properties and types

### Extended Functionality
- [coenttb-html](https://github.com/coenttb/coenttb-html): Extensions for HTML, Markdown, Email, and PDF generation
- [pointfree-html-to-pdf](https://github.com/coenttb/swift-html-to-pdf): Convert HTML to PDF on iOS and macOS

### Server & Web
- [swift-web](https://github.com/coenttb/swift-web): Modular web development tools
- [coenttb-web](https://github.com/coenttb/coenttb-web): Feature collection for Swift servers
- [coenttb-server](https://github.com/coenttb/coenttb-server): Modern Swift server framework
- [coenttb-server-vapor](https://github.com/coenttb/coenttb-server-vapor): Vapor integration

### Utilities
- **[swift-languages](https://github.com/coenttb/swift-languages)**: Cross-platform translation library

## Documentation

Comprehensive documentation is available at the [Swift Package Index](https://swiftpackageindex.com/coenttb/pointfree-html/main/documentation/pointfreehtml).

## Acknowledgements

This project builds upon the foundational work by Point-Free (Brandon Williams and Stephen Celis). PointFreeHTML is a fork and adaptation of their original swift-html library.

## Contributing

Contributions are welcome! Please feel free to:

- Open issues for bugs or feature requests
- Submit pull requests
- Improve documentation
- Share your projects built with PointFreeHTML

## Feedback & Support

- **Issues**: [GitHub Issues](https://github.com/coenttb/pointfree-html/issues)
- **Newsletter**: [Subscribe](http://coenttb.com/en/newsletter/subscribe)
- **Social**: [Follow @coenttb](http://x.com/coenttb)
- **Professional**: [LinkedIn](https://www.linkedin.com/in/tenthijeboonkkamp)

## License

PointFreeHTML is licensed under the MIT License. See [LICENSE](LICENSE) for details.
