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
    
    func testDate() {
        
        // Given
        let value = Date()
        let key = Key<Date>("key")
        
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
        let key = Key<[Int]>("test value of key at testClear()")
        
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

    func testAutoProperty(){

        //basic test
        defaults.autoStringProperty = "string value"
        XCTAssertTrue(defaults.has(Key<String>("autoStringProperty")))
        XCTAssertEqual(Defaults.shared.autoStringProperty,"string value")

        //test default value
        XCTAssertTrue(Defaults.shared.autoStringPropertyWithDefaultValue != nil)
        XCTAssertTrue(defaults.has(Key<String>("autoStringPropertyWithDefaultValue")))
        XCTAssertTrue(
               defaults.autoStringPropertyWithDefaultValue == Defaults.testValue_autoStringPropertyWithDefaultValue_defaultValue
                || defaults.autoStringPropertyWithDefaultValue == Defaults.testValue_autoStringPropertyWithDefaultValue_newValue
        )

        defaults.autoStringPropertyWithDefaultValue = Defaults.testValue_autoStringPropertyWithDefaultValue_newValue
        XCTAssertEqual(Defaults.shared.autoStringPropertyWithDefaultValue, Defaults.testValue_autoStringPropertyWithDefaultValue_newValue)

        //test custom value type with optional
        XCTAssertTrue(defaults.autoCustomOptionalProperty == nil)
        XCTAssertFalse(defaults.has(Key<CustomValueType>("autoCustomOptionalProperty")))

        //test for a case without default value
        defaults.autoCustomOptionalProperty = CustomValueType()
        XCTAssertTrue(defaults.autoCustomOptionalProperty != nil)
        defaults.autoCustomOptionalProperty = nil
        XCTAssertTrue(defaults.autoCustomOptionalProperty == nil)

        //test for a case with default setter's value
        defaults.autoCustomOptionalPropertySetterDefaultValue = nil
        XCTAssertTrue(defaults.autoCustomOptionalPropertySetterDefaultValue != nil)
        XCTAssertTrue(defaults.autoCustomOptionalPropertyGetterDefaultValue != nil)

        //test custom value type with non optional
        XCTAssertTrue(defaults.autoCustomNonOptionalProperty != nil)
        XCTAssertTrue(defaults.autoCustomNonOptionalProperty.key == "value")
        XCTAssertTrue(defaults.has(Key<CustomValueType>("autoCustomNonOptionalProperty")))
    }
}

/*
    testAutoPropertyExtension
*/
struct CustomValueType: Codable{
    var key:String = "value"
}

extension Defaults: DefaultsAutoProperty {
    fileprivate static var testValue_autoStringPropertyWithDefaultValue_defaultValue:String{
        return "default string value"
    }
    fileprivate static var testValue_autoStringPropertyWithDefaultValue_newValue:String{
        return "new string value"
    }

    var autoStringProperty: String? {
        set(newValue){ set(newValue) } get{ return get() }
    }
    var autoDateProperty: Date? {
        set(newValue){ set(newValue) } get{ return get() }
    }

    // default value with 'or'
    var autoStringPropertyWithDefaultValue: String? {
        set(newValue){ set(newValue) } get{ return get(or:"default string value") }
    }
    // non-optional - must define lazily default value with the keyword 'or'
    var autoCustomNonOptionalProperty: CustomValueType {
        set(newValue){ set(newValue) } get{ return get(or: CustomValueType()) }
    }
    // optional - there are 4 ways with/without default value
    var autoCustomOptionalProperty: CustomValueType? {
        set(newValue){ set(newValue) } get{ return get() }
    }
    var autoCustomOptionalPropertySetterDefaultValue: CustomValueType? {
        set(newValue){ set(newValue, or: CustomValueType()) } get{ return get() }
    }
    var autoCustomOptionalPropertyGetterDefaultValue: CustomValueType? {
        set(newValue){ set(newValue) } get{ return get(or:CustomValueType()) }
    }
    var autoCustomOptionalPropertySetterGetterDefaultValue: CustomValueType? {
        set(newValue){ set(newValue, or: CustomValueType()) } get{ return get(or: CustomValueType()) }
    }
}