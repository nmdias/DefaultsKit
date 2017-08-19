//
//  DefaultsKitTests.swift
//  DefaultsKitTests
//
//  Created by Nuno Dias on 15/08/2017.
//  Copyright © 2017 Nuno Dias. All rights reserved.
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
    
    func testHas() {
        
        // Given
        let values = [1,2,3,4]
        let key = Key<[Int]>("key")
        
        // When
        defaults.set(values, for: key)
        
        // Then
        let hasKey = defaults.has(key: key)
        XCTAssertTrue(hasKey)
        
    }
    
    func testSet() {
        
        // Given
        let values = [1,2,3,4]
        let key = Key<[Int]>("key")
        
        // When
        defaults.set(values, for: key)
        
        // Then
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
        defaults.clear(key: key)
        
        // Then
        let savedValues = defaults.get(for: key)
        XCTAssertNil(savedValues)
        
    }
    
    func testSetObject() {
        
        // Given
        let child = Person(name: "Anne Greenwell", age: 30, children: [])
        let person = Person(name: "Bonnie Greenwell", age: 80, children: [child])
        let key = Key<Person>("personKey")
        
        // When
        defaults.set(person, for: key)
        
        // Then
        let savedPerson = defaults.get(for: key)
        XCTAssertEqual(savedPerson?.name, "Bonnie Greenwell")
        XCTAssertEqual(savedPerson?.age, 80)
        XCTAssertEqual(savedPerson?.children.first?.name, "Anne Greenwell")
        XCTAssertEqual(savedPerson?.children.first?.age, 30)
    }
    
}
