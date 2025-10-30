//
//  HTMLInlineStyleTests.swift
//  pointfree-html
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import PointFreeHTML
import PointFreeHTMLTestSupport
import Testing

@Suite(
  "HTMLInlineStyle Tests",
  .snapshots(record: .failed)
)
struct HTMLInlineStyleTests {

  @Test("Basic inline style")
  func basicInlineStyle() throws {
    let styledElement = tag("div") {
      HTMLText("styled content")
    }
    .inlineStyle("color", "red")

    let rendered = try String(HTMLDocument { styledElement })
    #expect(rendered.contains("color:red"))
    #expect(rendered.contains("styled content"))
  }

  @Test("Multiple inline styles")
  func multipleInlineStyles() throws {
    let styledElement = tag("div") {
      HTMLText("content")
    }
    .inlineStyle("color", "red")
    .inlineStyle("background-color", "blue")
    .inlineStyle("font-size", "16px")

    let rendered = try String(HTMLDocument { styledElement })
    #expect(rendered.contains("color:red"))
    #expect(rendered.contains("background-color:blue"))
    #expect(rendered.contains("font-size:16px"))
  }

  @Test("Style chaining")
  func styleChaining() throws {
    let styledElement = tag("p") {
      HTMLText("paragraph")
    }
    .inlineStyle("margin", "10px")
    .inlineStyle("padding", "5px")

    let rendered = try String(HTMLDocument { styledElement })
    #expect(rendered.contains("margin:10px"))
    #expect(rendered.contains("padding:5px"))
  }

  @Test("Style with attributes")
  func styleWithAttributes() throws {
    let element = tag("div") {
      HTMLText("content")
    }
    .attribute("class", "test-class")
    .inlineStyle("display", "flex")

    let rendered = try String(HTMLDocument { element })
    #expect(rendered.contains("class=\"test-class\""))
    #expect(rendered.contains("display:flex"))
  }

  @Test("Empty style value")
  func emptyStyleValue() throws {
    let styledElement = tag("div") {
      HTMLText("content")
    }
    .inlineStyle("color", "")

    let rendered = try String(HTMLDocument { styledElement })
    // Empty values might be omitted or rendered as empty
    #expect(rendered.contains("content"))
  }

  // MARK: - Snapshot Tests

  @Test("Basic inline style snapshot")
  func basicInlineStyleSnapshot() {
    assertInlineSnapshot(
      of: HTMLDocument {
        tag("div") {
          HTMLText("Styled content")
        }
        .inlineStyle("color", "red")
        .inlineStyle("font-size", "18px")
      },
      as: .html
    ) {
      """
      <!doctype html>
      <html>
        <head>
          <style>
      .color-dMYaj4{color:red}
      .font-size-TX0I34{font-size:18px}

          </style>
        </head>
        <body>
      <div class="color-dMYaj4 font-size-TX0I34">Styled content
      </div>
        </body>
      </html>
      """
    }
  }

  @Test("Complex styling snapshot")
  func complexStylingSnapshot() {
    assertInlineSnapshot(
      of: HTMLDocument {
        tag("div") {
          tag("h1") {
            HTMLText("Welcome")
          }
          .inlineStyle("color", "navy")
          .inlineStyle("font-family", "Arial, sans-serif")

          tag("p") {
            HTMLText("This paragraph has styling.")
          }
          .inlineStyle("color", "#333")
          .inlineStyle("padding", "10px")
          .inlineStyle("background-color", "#f5f5f5")
        }
        .attribute("class", "container")
      },
      as: .html
    ) {
      """
      <!doctype html>
      <html>
        <head>
          <style>
      .color-gIITD3{color:navy}
      .font-family-90F943{font-family:Arial, sans-serif}
      .color-L58EO2{color:#333}
      .padding-Fqw6a1{padding:10px}
      .background-color-9a32C{background-color:#f5f5f5}

          </style>
        </head>
        <body>
      <div class="container">
        <h1 class="color-gIITD3 font-family-90F943">Welcome
        </h1>
        <p class="color-L58EO2 padding-Fqw6a1 background-color-9a32C">This paragraph has styling.
        </p>
      </div>
        </body>
      </html>
      """
    }
  }

  @Test("Style with attributes snapshot")
  func styleWithAttributesSnapshot() {
    assertInlineSnapshot(
      of: HTMLDocument {
        tag("div") {
          tag("a") {
            HTMLText("Styled link")
          }
          .attribute("href", "https://example.com")
          .inlineStyle("color", "#007bff")
          .inlineStyle("text-decoration", "none")
        }
        .inlineStyle("padding", "20px")
      },
      as: .html
    ) {
      """
      <!doctype html>
      <html>
        <head>
          <style>
      .padding-6PqSI{padding:20px}
      .color-ABnQo4{color:#007bff}
      .text-decoration-Wl0y44{text-decoration:none}

          </style>
        </head>
        <body>
      <div class="padding-6PqSI"><a class="color-ABnQo4 text-decoration-Wl0y44" href="https://example.com">Styled link</a>
      </div>
        </body>
      </html>
      """
    }
  }
}
