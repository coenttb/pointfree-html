//
//  HTMLDocumentProtocolTests.swift
//  pointfree-html
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import Foundation
import PointFreeHTML
import PointFreeHtmlTestSupport
import Testing

@Suite(
    "HTMLDocumentProtocol Tests",
    .snapshots(record: .missing)
)
struct HTMLDocumentProtocolTests {

    @Test("Basic HTML document structure")
    func basicDocumentStructure() throws {
        let document = HTMLDocument {
            HTMLElement(tag: "div") {
                HTMLText("Body content")
            }
        } head: {
            HTMLElement(tag: "title") {
                HTMLText("Test Title")
            }
        }

        let rendered = try String(document)
        #expect(rendered.contains("<!doctype html>"))
        #expect(rendered.contains("<html"))
        #expect(rendered.contains("<head>"))
        #expect(rendered.contains("<title>Test Title</title>"))
        #expect(rendered.contains("</head>"))
        #expect(rendered.contains("<body>"))
        #expect(rendered.contains("Body content"))
        #expect(rendered.contains("</body>"))
        #expect(rendered.contains("</html>"))
    }

    // MARK: - Snapshot Tests

    @Test("Complete HTML document snapshot")
    func completeDocumentSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                HTMLElement(tag: "main") {
                    HTMLElement(tag: "section") {
                        HTMLElement(tag: "h1") {
                            HTMLText("Welcome to Our Site")
                        }
                        HTMLElement(tag: "p") {
                            HTMLText("This is a complete HTML document with proper structure.")
                        }
                    }
                    HTMLElement(tag: "aside") {
                        HTMLElement(tag: "h2") {
                            HTMLText("Sidebar")
                        }
                        HTMLElement(tag: "ul") {
                            HTMLElement(tag: "li") {
                                HTMLText("Link 1")
                            }
                            HTMLElement(tag: "li") {
                                HTMLText("Link 2")
                            }
                        }
                    }
                }
            } head: {
                HTMLElement(tag: "title") {
                    HTMLText("My Website")
                }
                HTMLElement(tag: "meta")
                    .attribute("charset", "utf-8")
                HTMLElement(tag: "meta")
                    .attribute("name", "viewport")
                    .attribute("content", "width=device-width, initial-scale=1")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>My Website
                </title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>

                </style>
              </head>
              <body>
            <main>
              <section>
                <h1>Welcome to Our Site
                </h1>
                <p>This is a complete HTML document with proper structure.
                </p>
              </section>
              <aside>
                <h2>Sidebar
                </h2>
                <ul>
                  <li>Link 1
                  </li>
                  <li>Link 2
                  </li>
                </ul>
              </aside>
            </main>
              </body>
            </html>
            """
        }
    }
}
