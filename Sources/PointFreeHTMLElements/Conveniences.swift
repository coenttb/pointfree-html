//
//  File.swift
//  pointfree-html
//
//  Created by Coen ten Thije Boonkkamp on 20/07/2025.
//

extension HTML {
    /// Sets the alt attribute for accessibility descriptions of visual elements.
    public func alt(_ value: String?) -> _HTMLAttributes<Self> { attribute("alt", value) }

    /// Sets the href attribute for hyperlinks and other elements that link to URLs.
    public func href(_ value: String?) -> _HTMLAttributes<Self> { attribute("href", value) }

    /// Sets the rel attribute to specify the relationship between the current document and the linked resource.
    public func rel(_ value: String?) -> _HTMLAttributes<Self> { attribute("rel", value) }

    /// Sets the src attribute to specify the URL of a resource to include.
    public func src(_ value: String?) -> _HTMLAttributes<Self> { attribute("src", value) }

    /// Deprecated method that should not be used.
    @available(*, unavailable, message: "Use 'attribute(\"title\", value)' instead")
    public func title(_ value: String?) -> _HTMLAttributes<Self> { attribute("title", value) }
}
