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
        
        // When
        defaults.set(value, for: .integerKey)
        
        // Then
        let hasKey = defaults.has(.integerKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .integerKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testFloat() {
        
        // Given
        let value: Float = 123.1
        
        // When
        defaults.set(value, for: .floatKey)
        
        // Then
        let hasKey = defaults.has(.floatKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .floatKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testDouble() {
        
        // Given
        let value: Double = 123.1
        
        // When
        defaults.set(value, for: .doubleKey)
        
        // Then
        let hasKey = defaults.has(.doubleKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .doubleKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testString() {
        
        // Given
        let value = "a string"
        
        // When
        defaults.set(value, for: .stringKey)
        
        // Then
        let hasKey = defaults.has(.stringKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .stringKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testBool() {
        
        // Given
        let value = true
        
        // When
        defaults.set(value, for: .boolKey)
        
        // Then
        let hasKey = defaults.has(.boolKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .boolKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testDate() {
        
        // Given
        let value = Date()
        
        // When
        defaults.set(value, for: .dateKey)
        
        // Then
        let hasKey = defaults.has(.dateKey)
        XCTAssertTrue(hasKey)
        
        let savedValue = defaults.get(for: .dateKey)
        XCTAssertEqual(savedValue, value)
        
    }
    
    func testSet() {
        
        // Given
        let values = [1,2,3,4]
        
        // When
        defaults.set(values, for: .arrayOfIntegersKey)
        
        // Then
        let hasKey = defaults.has(.arrayOfIntegersKey)
        XCTAssertTrue(hasKey)
        
        let savedValues = defaults.get(for: .arrayOfIntegersKey)
        XCTAssertNotNil(savedValues)
        savedValues?.forEach({ (value) in
            XCTAssertTrue(savedValues?.contains(value) ?? false)
        })
        
    }
    
    func testClear() {
        
        // Given
        let values = [1,2,3,4]
        
        // When
        defaults.set(values, for: .arrayOfIntegersKey)
        defaults.clear(.arrayOfIntegersKey)
        
        // Then
        let hasKey = defaults.has(.arrayOfIntegersKey)
        XCTAssertFalse(hasKey)
        
        let savedValues = defaults.get(for: .arrayOfIntegersKey)
        XCTAssertNil(savedValues)
        
    }
    
    func testSetObject() {
     
        // Given
        let child = PersonMock(name: "Anne Greenwell", age: 30, children: [])
        let person = PersonMock(name: "Bonnie Greenwell", age: 80, children: [child])
        
        // When
        defaults.set(person, for: .personMockKey)
        
        // Then
        let hasKey = defaults.has(.personMockKey)
        XCTAssertTrue(hasKey)
        
        let savedPerson = defaults.get(for: .personMockKey)
        XCTAssertEqual(savedPerson?.name, "Bonnie Greenwell")
        XCTAssertEqual(savedPerson?.age, 80)
        XCTAssertEqual(savedPerson?.children.first?.name, "Anne Greenwell")
        XCTAssertEqual(savedPerson?.children.first?.age, 30)
    }
    
}
