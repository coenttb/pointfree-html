# ``PointFreeHTML``

Render any Swift type as HTML. 

## Getting Started

### Installation

Add PointFreeHTML to your Swift package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/pointfree-html.git", from: "0.0.1")
]
```

### Basic Usage

Import the library and create your HTML:

```swift
import PointFreeHTML

// Create a simple HTML element
let content = tag("p") {
    "Hello, "
       tag("b") { "World" }
    "!"
}

let htmlString = String(bytes: content.render(), encoding: .utf8)!
```


### Creating Complete HTML Documents

For full HTML documents, conform to the `HTMLDocument` protocol:

```swift
struct HomePage: HTMLDocument {
    var head: some HTML {
        tag("title") { "Home Page" }
        tag("meta").attribute("charset", "utf-8")
    }
    
    var body: some HTML {
        tag("div") {
            tag("h1") { "Welcome" }
            tag("p") { "This is my home page." }
        }
    }
}

let document = try String(HomePage())
```

## Topics

### Core Components

- ``HTML``
- ``HTMLDocument``
- ``HTMLBuilder``
- ``HTMLElement``
- ``HTMLTag``

### HTML Content

- ``HTMLText``
- ``HTMLRaw``
- ``HTMLEmpty``
- ``HTMLGroup``
- ``HTMLForEach``

### Styling

- ``HTMLInlineStyle``
- ``MediaQuery``
- ``Pseudo``

### Attributes

- ``_HTMLAttributes``
- ``InputType``

### Rendering

- ``HTMLPrinter``

### Articles

- <doc:BuildingReusableComponents>
