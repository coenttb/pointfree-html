//
//  PointFreeHTMLElements Tests.swift
//  pointfree-html
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

import Foundation
import PointFreeHTML
import PointFreeHTMLElements
import PointFreeHTMLTestSupport
import Testing

@Suite(
    "PointFreeHTMLElements Tests",
    .snapshots(record: .missing)
)
struct PointFreeHTMLElementsTests {

    // MARK: - Semantic Structure Elements

    @Test("Semantic HTML5 structure snapshot")
    func semanticStructureSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                main {
                    header {
                        nav {
                            h1 { "Site Title" }
                            ul {
                                li {
                                    a { "Home" }
                                        .href("/")
                                }
                                li {
                                    a { "About" }
                                        .href("/about")
                                }
                                li {
                                    a { "Contact" }
                                        .href("/contact")
                                }
                            }
                            .attribute("class", "nav-list")
                        }
                        .attribute("class", "navigation")
                    }
                    .attribute("role", "banner")

                    article {
                        header {
                            h2 { "Article Title" }
                            time { "2025-01-20" }
                                .attribute("datetime", "2025-01-20")
                        }

                        section {
                            p { "This is the first paragraph of the article content." }
                            p {
                                HTMLText("This paragraph contains ")
                                strong { "bold text" }
                                HTMLText(" and ")
                                em { "italic text" }
                                HTMLText(".")
                            }

                            blockquote {
                                p { "This is a quote from someone important." }
                                cite { "Famous Person" }
                                    .attribute("cite", "https://example.com")
                            }
                        }

                        footer {
                            p { "Published by Author Name" }
                        }
                    }
                    .attribute("class", "main-article")

                    aside {
                        h3 { "Related Links" }
                        ul {
                            li {
                                a { "Related Article 1" }
                                    .href("/related-1")
                            }
                            li {
                                a { "Related Article 2" }
                                    .href("/related-2")
                            }
                        }
                    }
                    .attribute("class", "sidebar")

                    footer {
                        p { "© 2025 Website Name. All rights reserved." }
                    }
                    .attribute("role", "contentinfo")
                }
            } head: {
                title { "Semantic HTML5 Example" }
                meta()
                    .attribute("charset", "utf-8")
                meta()
                    .attribute("name", "viewport")
                    .attribute("content", "width=device-width, initial-scale=1")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Semantic HTML5 Example
                </title>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>

                </style>
              </head>
              <body>
            <main>
              <header role="banner">
                <nav class="navigation">
                  <h1>Site Title
                  </h1>
                  <ul class="nav-list">
                    <li><a href="/">Home</a>
                    </li>
                    <li><a href="/about">About</a>
                    </li>
                    <li><a href="/contact">Contact</a>
                    </li>
                  </ul>
                </nav>
              </header>
              <article class="main-article">
                <header>
                  <h2>Article Title
                  </h2><time datetime="2025-01-20">2025-01-20</time>
                </header>
                <section>
                  <p>This is the first paragraph of the article content.
                  </p>
                  <p>This paragraph contains <strong>bold text</strong> and <em>italic text</em>.
                  </p>
                  <blockquote>
                    <p>This is a quote from someone important.
                    </p><cite cite="https://example.com">Famous Person</cite>
                  </blockquote>
                </section>
                <footer>
                  <p>Published by Author Name
                  </p>
                </footer>
              </article>
              <aside class="sidebar">
                <h3>Related Links
                </h3>
                <ul>
                  <li><a href="/related-1">Related Article 1</a>
                  </li>
                  <li><a href="/related-2">Related Article 2</a>
                  </li>
                </ul>
              </aside>
              <footer role="contentinfo">
                <p>© 2025 Website Name. All rights reserved.
                </p>
              </footer>
            </main>
              </body>
            </html>
            """
        }
    }

    // MARK: - Form Elements

    @Test("Complete form elements snapshot")
    func completeFormSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                div {
                    h1 { "Contact Form" }

                    form {
                        fieldset {
                            legend { "Personal Information" }

                            div {
                                label { "Full Name:" }
                                    .attribute("for", "fullname")
                                input()
                                    .attribute("type", "text")
                                    .attribute("id", "fullname")
                                    .attribute("name", "fullname")
                                    .attribute("required", "")
                                    .attribute("placeholder", "Enter your full name")
                            }
                            .attribute("class", "form-group")

                            div {
                                label { "Email Address:" }
                                    .attribute("for", "email")
                                input()
                                    .attribute("type", "email")
                                    .attribute("id", "email")
                                    .attribute("name", "email")
                                    .attribute("required", "")
                                    .attribute("placeholder", "your@email.com")
                            }
                            .attribute("class", "form-group")

                            div {
                                label { "Phone Number:" }
                                    .attribute("for", "phone")
                                input()
                                    .attribute("type", "tel")
                                    .attribute("id", "phone")
                                    .attribute("name", "phone")
                                    .attribute("placeholder", "(555) 123-4567")
                            }
                            .attribute("class", "form-group")
                        }

                        fieldset {
                            legend { "Preferences" }

                            div {
                                input()
                                    .attribute("type", "checkbox")
                                    .attribute("id", "newsletter")
                                    .attribute("name", "newsletter")
                                    .attribute("value", "yes")
                                label { "Subscribe to newsletter" }
                                    .attribute("for", "newsletter")
                            }
                            .attribute("class", "checkbox-group")

                            div {
                                label { "Preferred Contact Method:" }
                                select {
                                    option { "Email" }
                                        .attribute("value", "email")
                                        .attribute("selected", "")
                                    option { "Phone" }
                                        .attribute("value", "phone")
                                    option { "Mail" }
                                        .attribute("value", "mail")
                                }
                                .attribute("name", "contact_method")
                            }
                            .attribute("class", "form-group")

                            div {
                                label { "Message:" }
                                    .attribute("for", "message")
                                textarea { "Please enter your message here..." }
                                    .attribute("id", "message")
                                    .attribute("name", "message")
                                    .attribute("rows", "5")
                                    .attribute("cols", "50")
                            }
                            .attribute("class", "form-group")
                        }

                        div {
                            button { "Submit Form" }
                                .attribute("type", "submit")
                                .attribute("class", "btn-primary")
                            button { "Reset Form" }
                                .attribute("type", "reset")
                                .attribute("class", "btn-secondary")
                        }
                        .attribute("class", "form-actions")
                    }
                    .attribute("method", "post")
                    .attribute("action", "/submit-contact")
                }
                .attribute("class", "form-container")
            } head: {
                title { "Contact Form Example" }
                meta()
                    .attribute("charset", "utf-8")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Contact Form Example
                </title>
                <meta charset="utf-8">
                <style>

                </style>
              </head>
              <body>
            <div class="form-container">
              <h1>Contact Form
              </h1>
              <form method="post" action="/submit-contact">
                <fieldset>
                  <legend>Personal Information
                  </legend>
                  <div class="form-group"><label for="fullname">Full Name:</label><input type="text" id="fullname" name="fullname" required placeholder="Enter your full name">
                  </div>
                  <div class="form-group"><label for="email">Email Address:</label><input type="email" id="email" name="email" required placeholder="your@email.com">
                  </div>
                  <div class="form-group"><label for="phone">Phone Number:</label><input type="tel" id="phone" name="phone" placeholder="(555) 123-4567">
                  </div>
                </fieldset>
                <fieldset>
                  <legend>Preferences
                  </legend>
                  <div class="checkbox-group"><input type="checkbox" id="newsletter" name="newsletter" value="yes"><label for="newsletter">Subscribe to newsletter</label>
                  </div>
                  <div class="form-group"><label>Preferred Contact Method:</label><select name="contact_method">
                    <option value="email" selected>Email
                    </option>
                    <option value="phone">Phone
                    </option>
                    <option value="mail">Mail
                    </option></select>
                  </div>
                  <div class="form-group"><label for="message">Message:</label><textarea id="message" name="message" rows="5" cols="50">Please enter your message here...</textarea>
                  </div>
                </fieldset>
                <div class="form-actions"><button type="submit" class="btn-primary">Submit Form</button><button type="reset" class="btn-secondary">Reset Form</button>
                </div>
              </form>
            </div>
              </body>
            </html>
            """
        }
    }

    // MARK: - Table Elements

    @Test("Data table snapshot")
    func dataTableSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                div {
                    h2 { "Employee Data" }

                    table {
                        caption { "Employee information for Q4 2024" }

                        thead {
                            tr {
                                th { "Name" }
                                    .attribute("scope", "col")
                                th { "Department" }
                                    .attribute("scope", "col")
                                th { "Salary" }
                                    .attribute("scope", "col")
                                th { "Start Date" }
                                    .attribute("scope", "col")
                            }
                        }

                        tbody {
                            tr {
                                td { "John Doe" }
                                td { "Engineering" }
                                td { "$75,000" }
                                td {
                                    time { "Jan 15, 2023" }
                                        .attribute("datetime", "2023-01-15")
                                }
                            }
                            tr {
                                td { "Jane Smith" }
                                td { "Marketing" }
                                td { "$65,000" }
                                td {
                                    time { "Mar 10, 2023" }
                                        .attribute("datetime", "2023-03-10")
                                }
                            }
                            tr {
                                td { "Bob Johnson" }
                                td { "Sales" }
                                td { "$55,000" }
                                td {
                                    time { "May 20, 2023" }
                                        .attribute("datetime", "2023-05-20")
                                }
                            }
                        }

                        tfoot {
                            tr {
                                td { "Total Employees: 3" }
                                    .attribute("colspan", "4")
                            }
                        }
                    }
                    .attribute("class", "data-table")
                    .attribute("border", "1")
                }
            } head: {
                title { "Employee Table" }
                meta()
                    .attribute("charset", "utf-8")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Employee Table
                </title>
                <meta charset="utf-8">
                <style>

                </style>
              </head>
              <body>
            <div>
              <h2>Employee Data
              </h2>
              <table class="data-table" border="1">
                <caption>Employee information for Q4 2024
                </caption>
                <thead>
                  <tr>
                    <th scope="col">Name
                    </th>
                    <th scope="col">Department
                    </th>
                    <th scope="col">Salary
                    </th>
                    <th scope="col">Start Date
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>John Doe
                    </td>
                    <td>Engineering
                    </td>
                    <td>$75,000
                    </td>
                    <td><time datetime="2023-01-15">Jan 15, 2023</time>
                    </td>
                  </tr>
                  <tr>
                    <td>Jane Smith
                    </td>
                    <td>Marketing
                    </td>
                    <td>$65,000
                    </td>
                    <td><time datetime="2023-03-10">Mar 10, 2023</time>
                    </td>
                  </tr>
                  <tr>
                    <td>Bob Johnson
                    </td>
                    <td>Sales
                    </td>
                    <td>$55,000
                    </td>
                    <td><time datetime="2023-05-20">May 20, 2023</time>
                    </td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="4">Total Employees: 3
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
              </body>
            </html>
            """
        }
    }

    // MARK: - Media Elements

    @Test("Media elements snapshot")
    func mediaElementsSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                article {
                    h1 { "Media Gallery" }

                    section {
                        h2 { "Images" }

                        figure {
                            img()
                                .attribute("src", "/images/landscape.jpg")
                                .attribute("alt", "Beautiful mountain landscape")
                                .attribute("width", "600")
                                .attribute("height", "400")
                                .attribute("loading", "lazy")

                            figcaption {
                                HTMLText("A stunning view of the mountains at sunrise. Photo by ")
                                cite { "Nature Photographer" }
                            }
                        }
                        .attribute("class", "image-figure")

                        picture {
                            source()
                                .attribute("media", "(min-width: 800px)")
                                .attribute("srcset", "/images/large.webp")
                            source()
                                .attribute("media", "(min-width: 400px)")
                                .attribute("srcset", "/images/medium.webp")
                            img()
                                .attribute("src", "/images/small.jpg")
                                .attribute("alt", "Responsive image")
                        }
                    }

                    section {
                        h2 { "Videos" }

                        video {
                            source()
                                .attribute("src", "/videos/sample.mp4")
                                .attribute("type", "video/mp4")
                            source()
                                .attribute("src", "/videos/sample.webm")
                                .attribute("type", "video/webm")
                            p { "Your browser doesn't support HTML5 video." }
                        }
                        .attribute("controls", "")
                        .attribute("width", "640")
                        .attribute("height", "480")
                        .attribute("poster", "/images/video-poster.jpg")

                        audio {
                            source()
                                .attribute("src", "/audio/sample.mp3")
                                .attribute("type", "audio/mpeg")
                            source()
                                .attribute("src", "/audio/sample.ogg")
                                .attribute("type", "audio/ogg")
                            p { "Your browser doesn't support HTML5 audio." }
                        }
                        .attribute("controls", "")
                    }

                    section {
                        h2 { "Interactive Content" }

                        details {
                            summary { "Click to expand details" }
                            p { "This content is hidden by default and can be expanded by clicking the summary." }
                            ul {
                                li { "Detail item 1" }
                                li { "Detail item 2" }
                                li { "Detail item 3" }
                            }
                        }

                        progress {
                            HTMLText("Loading...")
                        }
                        .attribute("value", "75")
                        .attribute("max", "100")

                        meter {
                            HTMLText("8 out of 10")
                        }
                        .attribute("value", "8")
                        .attribute("min", "0")
                        .attribute("max", "10")
                    }
                }
            } head: {
                title { "Media Elements Example" }
                meta()
                    .attribute("charset", "utf-8")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Media Elements Example
                </title>
                <meta charset="utf-8">
                <style>

                </style>
              </head>
              <body>
            <article>
              <h1>Media Gallery
              </h1>
              <section>
                <h2>Images
                </h2>
                <figure class="image-figure"><img src="/images/landscape.jpg" alt="Beautiful mountain landscape" width="600" height="400" loading="lazy">
                  <figcaption>A stunning view of the mountains at sunrise. Photo by <cite>Nature Photographer</cite>
                  </figcaption>
                </figure>
                <picture>
                  <source media="(min-width: 800px)" srcset="/images/large.webp">
                  <source media="(min-width: 400px)" srcset="/images/medium.webp"><img src="/images/small.jpg" alt="Responsive image">
                </picture>
              </section>
              <section>
                <h2>Videos
                </h2>
                <video controls width="640" height="480" poster="/images/video-poster.jpg">
                  <source src="/videos/sample.mp4" type="video/mp4">
                  <source src="/videos/sample.webm" type="video/webm">
                  <p>Your browser doesn't support HTML5 video.
                  </p>
                </video>
                <audio controls>
                  <source src="/audio/sample.mp3" type="audio/mpeg">
                  <source src="/audio/sample.ogg" type="audio/ogg">
                  <p>Your browser doesn't support HTML5 audio.
                  </p>
                </audio>
              </section>
              <section>
                <h2>Interactive Content
                </h2>
                <details>
                  <summary>Click to expand details
                  </summary>
                  <p>This content is hidden by default and can be expanded by clicking the summary.
                  </p>
                  <ul>
                    <li>Detail item 1
                    </li>
                    <li>Detail item 2
                    </li>
                    <li>Detail item 3
                    </li>
                  </ul>
                </details>
                <progress value="75" max="100">Loading...
                </progress>
                <meter value="8" min="0" max="10">8 out of 10
                </meter>
              </section>
            </article>
              </body>
            </html>
            """
        }
    }

    // MARK: - Text Formatting Elements

    @Test("Text formatting elements snapshot")
    func textFormattingSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                article {
                    h1 { "Text Formatting Examples" }

                    section {
                        h2 { "Basic Text Formatting" }

                        p {
                            HTMLText("This paragraph demonstrates various text formatting: ")
                            strong { "bold text" }
                            HTMLText(", ")
                            em { "italic text" }
                            HTMLText(", ")
                            mark { "highlighted text" }
                            HTMLText(", ")
                            small { "small text" }
                            HTMLText(", ")
                            del { "deleted text" }
                            HTMLText(", and ")
                            ins { "inserted text" }
                            HTMLText(".")
                        }

                        p {
                            HTMLText("Here we have ")
                            sub { "subscript" }
                            HTMLText(" and ")
                            sup { "superscript" }
                            HTMLText(" text, as well as ")
                            code { "inline code" }
                            HTMLText(" and ")
                            kbd { "keyboard input" }
                            HTMLText(".")
                        }

                        p {
                            HTMLText("Technical terms can be marked with ")
                            dfn { "definition" }
                            HTMLText(" tags, and variables with ")
                            `var` { "variable" }
                            HTMLText(" tags.")
                        }
                    }

                    section {
                        h2 { "Code and Preformatted Text" }

                        p { "Here's a code block:" }

                        pre {
                            code {
                                HTMLText("""
function hello() {
    console.log("Hello, World!");
    return true;
}
""")
                            }
                        }
                        .attribute("class", "code-block")

                        p {
                            HTMLText("And here's some sample output: ")
                            samp { "Hello, World!" }
                        }
                    }

                    section {
                        h2 { "Quotations and Citations" }

                        blockquote {
                            p { "The best way to predict the future is to invent it." }
                            footer {
                                HTMLText("— ")
                                cite { "Alan Kay" }
                            }
                        }

                        p {
                            HTMLText("As someone once said, ")
                            q { "brevity is the soul of wit" }
                            HTMLText(".")
                        }
                        .attribute("cite", "https://shakespeare.example.com")
                    }

                    section {
                        h2 { "Abbreviations and Addresses" }

                        p {
                            HTMLText("The ")
                            abbr { "WWW" }
                                .attribute("title", "World Wide Web")
                            HTMLText(" revolutionized information sharing.")
                        }

                        address {
                            HTMLText("Contact us at:")
                            br()
                            HTMLText("123 Web Street")
                            br()
                            HTMLText("Internet City, IC 12345")
                            br()
                            a { "contact@example.com" }
                                .href("mailto:contact@example.com")
                        }
                    }
                }
            } head: {
                title { "Text Formatting Examples" }
                meta()
                    .attribute("charset", "utf-8")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Text Formatting Examples
                </title>
                <meta charset="utf-8">
                <style>

                </style>
              </head>
              <body>
            <article>
              <h1>Text Formatting Examples
              </h1>
              <section>
                <h2>Basic Text Formatting
                </h2>
                <p>This paragraph demonstrates various text formatting: <strong>bold text</strong>, <em>italic text</em>, 
                  <mark>highlighted text
                  </mark>, <small>small text</small>, 
                  <del>deleted text
                  </del>, and 
                  <ins>inserted text
                  </ins>.
                </p>
                <p>Here we have <sub>subscript</sub> and <sup>superscript</sup> text, as well as <code>inline code</code> and <kbd>keyboard input</kbd>.
                </p>
                <p>Technical terms can be marked with <dfn>definition</dfn> tags, and variables with <var>variable</var> tags.
                </p>
              </section>
              <section>
                <h2>Code and Preformatted Text
                </h2>
                <p>Here's a code block:
                </p>
                <pre class="code-block"><code>function hello() {
                console.log("Hello, World!");
                return true;
            }</code></pre>
                <p>And here's some sample output: <samp>Hello, World!</samp>
                </p>
              </section>
              <section>
                <h2>Quotations and Citations
                </h2>
                <blockquote>
                  <p>The best way to predict the future is to invent it.
                  </p>
                  <footer>— <cite>Alan Kay</cite>
                  </footer>
                </blockquote>
                <p cite="https://shakespeare.example.com">As someone once said, <q>brevity is the soul of wit</q>.
                </p>
              </section>
              <section>
                <h2>Abbreviations and Addresses
                </h2>
                <p>The <abbr title="World Wide Web">WWW</abbr> revolutionized information sharing.
                </p>
                <address>Contact us at:<br>123 Web Street<br>Internet City, IC 12345<br><a href="mailto:contact@example.com">contact@example.com</a>
                </address>
              </section>
            </article>
              </body>
            </html>
            """
        }
    }

    // MARK: - Lists and Navigation

    @Test("Lists and navigation snapshot")
    func listsAndNavigationSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                div {
                    nav {
                        h2 { "Site Navigation" }
                        ul {
                            li {
                                a { "Home" }
                                    .href("/")
                                    .attribute("aria-current", "page")
                            }
                            li {
                                a { "Products" }
                                    .href("/products")
                                ul {
                                    li {
                                        a { "Widgets" }
                                            .href("/products/widgets")
                                    }
                                    li {
                                        a { "Gadgets" }
                                            .href("/products/gadgets")
                                    }
                                }
                                .attribute("class", "submenu")
                            }
                            li {
                                a { "About" }
                                    .href("/about")
                            }
                        }
                        .attribute("class", "main-nav")
                    }
                    .attribute("aria-label", "Main navigation")

                    main {
                        section {
                            h1 { "Different List Types" }

                            h2 { "Ordered List" }
                            ol {
                                li { "First step in the process" }
                                li { "Second step with more details" }
                                li {
                                    HTMLText("Third step with ")
                                    strong { "important" }
                                    HTMLText(" information")
                                }
                                li { "Final step to completion" }
                            }
                            .attribute("start", "1")

                            h2 { "Unordered List with Mixed Content" }
                            ul {
                                li {
                                    HTMLText("Item with ")
                                    a { "a link" }
                                        .href("https://example.com")
                                }
                                li {
                                    HTMLText("Item with ")
                                    code { "code snippet" }
                                }
                                li {
                                    HTMLText("Item with nested content:")
                                    ul {
                                        li { "Nested item 1" }
                                        li { "Nested item 2" }
                                    }
                                }
                            }

                            h2 { "Description List" }
                            dl {
                                dt { "HTML" }
                                dd { "HyperText Markup Language - the standard markup language for web pages." }

                                dt { "CSS" }
                                dd { "Cascading Style Sheets - describes how HTML elements are displayed." }

                                dt { "JavaScript" }
                                dd { "Programming language that enables interactive web pages." }
                                dd { "Essential part of web applications alongside HTML and CSS." }
                            }
                        }
                    }
                }
                .attribute("class", "page-container")
            } head: {
                title { "Lists and Navigation Examples" }
                meta()
                    .attribute("charset", "utf-8")
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Lists and Navigation Examples
                </title>
                <meta charset="utf-8">
                <style>

                </style>
              </head>
              <body>
            <div class="page-container">
              <nav aria-label="Main navigation">
                <h2>Site Navigation
                </h2>
                <ul class="main-nav">
                  <li><a href="/" aria-current="page">Home</a>
                  </li>
                  <li><a href="/products">Products</a>
                    <ul class="submenu">
                      <li><a href="/products/widgets">Widgets</a>
                      </li>
                      <li><a href="/products/gadgets">Gadgets</a>
                      </li>
                    </ul>
                  </li>
                  <li><a href="/about">About</a>
                  </li>
                </ul>
              </nav>
              <main>
                <section>
                  <h1>Different List Types
                  </h1>
                  <h2>Ordered List
                  </h2>
                  <ol start="1">
                    <li>First step in the process
                    </li>
                    <li>Second step with more details
                    </li>
                    <li>Third step with <strong>important</strong> information
                    </li>
                    <li>Final step to completion
                    </li>
                  </ol>
                  <h2>Unordered List with Mixed Content
                  </h2>
                  <ul>
                    <li>Item with <a href="https://example.com">a link</a>
                    </li>
                    <li>Item with <code>code snippet</code>
                    </li>
                    <li>Item with nested content:
                      <ul>
                        <li>Nested item 1
                        </li>
                        <li>Nested item 2
                        </li>
                      </ul>
                    </li>
                  </ul>
                  <h2>Description List
                  </h2>
                  <dl>
                    <dt>HTML
                    </dt>
                    <dd>HyperText Markup Language - the standard markup language for web pages.
                    </dd>
                    <dt>CSS
                    </dt>
                    <dd>Cascading Style Sheets - describes how HTML elements are displayed.
                    </dd>
                    <dt>JavaScript
                    </dt>
                    <dd>Programming language that enables interactive web pages.
                    </dd>
                    <dd>Essential part of web applications alongside HTML and CSS.
                    </dd>
                  </dl>
                </section>
              </main>
            </div>
              </body>
            </html>
            """
        }
    }

    // MARK: - Embedded Content and Scripts

    @Test("Embedded content and scripts snapshot")
    func embeddedContentSnapshot() {
        assertInlineSnapshot(
            of: HTMLDocument {
                div {
                    h1 { "Embedded Content Examples" }

                    section {
                        h2 { "External Embeds" }

                        div {
                            iframe {
                                p { "Your browser doesn't support iframes." }
                            }
                            .attribute("src", "https://www.example.com")
                            .attribute("width", "600")
                            .attribute("height", "400")
                            .attribute("title", "External content")
                            .attribute("sandbox", "allow-scripts allow-same-origin")
                        }
                        .attribute("class", "iframe-container")

                        object {
                            param()
                                .attribute("name", "quality")
                                .attribute("value", "high")
                            embed()
                                .attribute("src", "/content/interactive.swf")
                                .attribute("type", "application/x-shockwave-flash")
                        }
                        .attribute("data", "/content/interactive.swf")
                        .attribute("type", "application/x-shockwave-flash")
                    }

                    section {
                        h2 { "Canvas and SVG" }

                        canvas {
                            p { "Your browser doesn't support the canvas element." }
                        }
                        .attribute("id", "myCanvas")
                        .attribute("width", "400")
                        .attribute("height", "200")

                        svg {
                            HTMLRaw("""
                            <rect x="10" y="10" width="100" height="100" fill="blue"/>
                            <circle cx="150" cy="60" r="40" fill="red"/>
                            <text x="10" y="150" font-family="Arial" font-size="14" fill="black">SVG Example</text>
                            """)
                        }
                        .attribute("width", "200")
                        .attribute("height", "150")
                        .attribute("viewBox", "0 0 200 150")
                    }

                    section {
                        h2 { "Scripts and Styles" }

                        div {
                            p { "This content will be styled and made interactive with JavaScript." }
                            button { "Click Me" }
                                .attribute("id", "interactive-button")
                                .attribute("class", "styled-button")
                        }
                        .attribute("id", "interactive-content")
                    }

                    script {
                        """
                        document.getElementById('interactive-button').addEventListener('click', function() {
                            alert('Button clicked!');
                            this.style.backgroundColor = 'green';
                        });
                        """
                    }

                    noscript {
                        p { "This website requires JavaScript to function properly. Please enable JavaScript in your browser." }
                    }
                }
                .attribute("class", "embedded-content-container")
            } head: {
                title { "Embedded Content Examples" }
                meta()
                    .attribute("charset", "utf-8")
                style {
                    """
                    .styled-button {
                        background-color: #007bff;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                    }
                    .styled-button:hover {
                        background-color: #0056b3;
                    }
                    #interactive-content {
                        border: 2px solid #ddd;
                        padding: 20px;
                        margin: 20px 0;
                        border-radius: 8px;
                    }
                    """
                }
            },
            as: .html
        ) {
            """
            <!doctype html>
            <html>
              <head>
                <title>Embedded Content Examples
                </title>
                <meta charset="utf-8">
                <style>.styled-button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }
            .styled-button:hover {
                background-color: #0056b3;
            }
            #interactive-content {
                border: 2px solid #ddd;
                padding: 20px;
                margin: 20px 0;
                border-radius: 8px;
            }
                </style>
                <style>

                </style>
              </head>
              <body>
            <div class="embedded-content-container">
              <h1>Embedded Content Examples
              </h1>
              <section>
                <h2>External Embeds
                </h2>
                <div class="iframe-container">
                  <iframe src="https://www.example.com" width="600" height="400" title="External content" sandbox="allow-scripts allow-same-origin">
                    <p>Your browser doesn't support iframes.
                    </p>
                  </iframe>
                </div><object data="/content/interactive.swf" type="application/x-shockwave-flash">
                <param name="quality" value="high">
                <embed src="/content/interactive.swf" type="application/x-shockwave-flash"></object>
              </section>
              <section>
                <h2>Canvas and SVG
                </h2>
                <canvas id="myCanvas" width="400" height="200">
                  <p>Your browser doesn't support the canvas element.
                  </p>
                </canvas>
                <svg width="200" height="150" viewBox="0 0 200 150"><rect x="10" y="10" width="100" height="100" fill="blue"/>
            <circle cx="150" cy="60" r="40" fill="red"/>
            <text x="10" y="150" font-family="Arial" font-size="14" fill="black">SVG Example</text>
                </svg>
              </section>
              <section>
                <h2>Scripts and Styles
                </h2>
                <div id="interactive-content">
                  <p>This content will be styled and made interactive with JavaScript.
                  </p><button id="interactive-button" class="styled-button">Click Me</button>
                </div>
              </section><script>document.getElementById('interactive-button').addEventListener('click', function() {
                alert('Button clicked!');
                this.style.backgroundColor = 'green';
            });</script>
              <noscript>
                <p>This website requires JavaScript to function properly. Please enable JavaScript in your browser.
                </p>
              </noscript>
            </div>
              </body>
            </html>
            """
        }
    }
}
