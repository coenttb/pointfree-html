////
////  PseudoTests.swift
////  pointfree-html
////
////  Created by Coen ten Thije Boonkkamp on 20/07/2025.
////
//
// import Foundation
// import PointFreeHTML
// import Testing
//
// @Suite("Pseudo Tests")
// struct PseudoTests {
//    
//    @Test("Pseudo class creation")
//    func pseudoClassCreation() throws {
//        let hover = Pseudo.hover
//        let active = Pseudo.active
//        let focus = Pseudo.focus
//        
//        // Test that pseudo classes can be created
//        #expect(hover.rawValue == ":hover")
//        #expect(active.rawValue == ":active")
//        #expect(focus.rawValue == ":focus")
//    }
//    
//    @Test("Pseudo element creation")
//    func pseudoElementCreation() throws {
//        let before = Pseudo.before
//        let after = Pseudo.after
//        let firstLine = Pseudo.firstLine
//        
//        #expect(before.rawValue == "::before")
//        #expect(after.rawValue == "::after")
//        #expect(firstLine.rawValue == "::first-line")
//    }
//    
//    @Test("Structural pseudo classes")
//    func structuralPseudoClasses() throws {
//        let firstChild = Pseudo.firstChild
//        let lastChild = Pseudo.lastChild
//        let nthChild = Pseudo.nthChild(2)
//        
//        #expect(firstChild.rawValue == ":first-child")
//        #expect(lastChild.rawValue == ":last-child")
//        #expect(nthChild.rawValue == ":nth-child(2)")
//    }
//    
//    @Test("Form pseudo classes")
//    func formPseudoClasses() throws {
//        let checked = Pseudo.checked
//        let disabled = Pseudo.disabled
//        let enabled = Pseudo.enabled
//        let required = Pseudo.required
//        
//        #expect(checked.rawValue == ":checked")
//        #expect(disabled.rawValue == ":disabled")
//        #expect(enabled.rawValue == ":enabled")
//        #expect(required.rawValue == ":required")
//    }
//    
//    @Test("Custom pseudo selector")
//    func customPseudoSelector() throws {
//        let custom = Pseudo.custom(":not(.hidden)")
//        
//        #expect(custom.rawValue == ":not(.hidden)")
//    }
//    
//    @Test("Pseudo with nth functions")
//    func pseudoWithNthFunctions() throws {
//        let nthOfType = Pseudo.nthOfType(3)
//        let nthLastChild = Pseudo.nthLastChild(1)
//        
//        #expect(nthOfType.rawValue == ":nth-of-type(3)")
//        #expect(nthLastChild.rawValue == ":nth-last-child(1)")
//    }
//    
//    @Test("Pseudo equality")
//    func pseudoEquality() throws {
//        let hover1 = Pseudo.hover
//        let hover2 = Pseudo.hover
//        let active = Pseudo.active
//        
//        #expect(hover1.rawValue == hover2.rawValue)
//        #expect(hover1.rawValue != active.rawValue)
//    }
// }
