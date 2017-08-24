//
//  DefaultsTests.swift
//
//  Copyright (c) 2017 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import DefaultsKit

class DefaultsKitTests: XCTestCase {
    
    var defaults: Defaults!
    
    override func setUp() {
        super.setUp()
        self.defaults = Defaults()
    }
    
    override func tearDown() {
        super.tearDown()
        self.defaults = nil
    }
    
    func testInteger() {
        
        // Given
        let value = 123
        let key = Key<Int>("key")
        
        // When
        defaults.set(value, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: key)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testFloat() {
        
        // Given
        let value: Float = 123.1
        let key = Key<Float>("key")
        
        // When
        defaults.set(value, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: key)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testDouble() {
        
        // Given
        let value: Double = 123.1
        let key = Key<Double>("key")
        
        // When
        defaults.set(value, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: key)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testString() {
        
        // Given
        let value = "a string"
        let key = Key<String>("key")
        
        // When
        defaults.set(value, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: key)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testBool() {
        
        // Given
        let value = true
        let key = Key<Bool>("key")
        
        // When
        defaults.set(value, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: key)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testSet() {
        
        // Given
        let values = [1,2,3,4]
        let key = Key<[Int]>("key")
        
        // When
        defaults.set(values, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedValues = defaults.get(for: key)
        XCTAssertNotNil(savedValues)
        savedValues?.forEach({ (value) in
            XCTAssertTrue(savedValues?.contains(value) ?? false)
        })
        
    }
    
    func testClear() {
        
        // Given
        let values = [1,2,3,4]
        let key = Key<[Int]>("key")
        
        // When
        defaults.set(values, for: key)
        defaults.clear(key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertFalse(hasKey)
        
        let savedValues = defaults.get(for: key)
        XCTAssertNil(savedValues)
        
    }
    
    func testSetObject() {
     
        // Mocks
        struct PersonMock: Codable {
            let name: String
            let age: Int
            let children: [PersonMock]
        }
        
        // Given
        let child = PersonMock(name: "Anne Greenwell", age: 30, children: [])
        let person = PersonMock(name: "Bonnie Greenwell", age: 80, children: [child])
        let key = Key<PersonMock>("personKey")
        
        // When
        defaults.set(person, for: key)
        
        // Then
        let hasKey = defaults.has(key)
        XCTAssertTrue(hasKey)
        
        let savedPerson = defaults.get(for: key)
        XCTAssertEqual(savedPerson?.name, "Bonnie Greenwell")
        XCTAssertEqual(savedPerson?.age, 80)
        XCTAssertEqual(savedPerson?.children.first?.name, "Anne Greenwell")
        XCTAssertEqual(savedPerson?.children.first?.age, 30)
    }
    
}
