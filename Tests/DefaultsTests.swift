//
//  DefaultsTests.swift
//
//  Copyright (c) 2017 - 204 Nuno Manuel Dias
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

@testable import DefaultsKit

import Foundation
import Testing

@Suite("DefaultsKit", .serialized)
struct DefaultsKitTests {
  @Test func testInteger() {
    // Given
    let defaults = Defaults()
    let expected: Int = 123

    // When
    defaults.set(expected, for: .integerKey)

    // Then
    let hasKey = defaults.has(.integerKey)
    #expect(hasKey)

    let actual = defaults.get(for: .integerKey)
    #expect(expected == actual)
  }

  @Test func testFloat() {
    // Given
    let defaults = Defaults()
    let expected: Float = 123.1

    // When
    defaults.set(expected, for: .floatKey)

    // Then
    let hasKey = defaults.has(.floatKey)
    #expect(hasKey)

    let actual = defaults.get(for: .floatKey)
    #expect(expected == actual)
  }

  @Test func testDouble() {
    // Given
    let defaults = Defaults()
    let expected: Double = 123.1

    // When
    defaults.set(expected, for: .doubleKey)

    // Then
    let hasKey = defaults.has(.doubleKey)
    #expect(hasKey)

    let actual = defaults.get(for: .doubleKey)
    #expect(expected == actual)
  }

  @Test func testString() {
    // Given
    let defaults = Defaults()
    let expected: String = "a string"

    // When
    defaults.set(expected, for: .stringKey)

    // Then
    let hasKey = defaults.has(.stringKey)
    #expect(hasKey)

    let actual = defaults.get(for: .stringKey)
    #expect(expected == actual)
  }

  @Test func testBool() {
    // Given
    let defaults = Defaults()
    let expected: Bool = true

    // When
    defaults.set(expected, for: .boolKey)

    // Then
    let hasKey = defaults.has(.boolKey)
    #expect(hasKey)

    let actual = defaults.get(for: .boolKey)
    #expect(expected == actual)
  }

  @Test func testDate() {
    // Given
    let defaults = Defaults()
    let expected: Date = Date()

    // When
    defaults.set(expected, for: .dateKey)

    // Then
    let hasKey = defaults.has(.dateKey)
    #expect(hasKey)

    let actual = defaults.get(for: .dateKey)
    #expect(expected == actual)
  }

  @Test func testEnum() {
    // Given
    let defaults = Defaults()
    let expected: EnumMock = .three

    // When
    defaults.set(expected, for: .enumKey)

    // Then
    let hasKey = defaults.has(.enumKey)
    #expect(hasKey)

    let actual = defaults.get(for: .enumKey)
    #expect(expected == actual)
  }

  @Test func testOptionSet() {
    // Given
    let defaults = Defaults()
    let expected: OptionSetMock = .option3

    // When
    defaults.set(expected, for: .optionSetKey)

    // Then
    let hasKey = defaults.has(.optionSetKey)
    #expect(hasKey)

    let actual = defaults.get(for: .optionSetKey)
    #expect(expected == actual)
  }

  @Test func testSet() {
    // Given
    let defaults = Defaults()
    let expected: [Int] = [1, 2, 3, 4]

    // When
    defaults.set(expected, for: .arrayOfIntegersKey)

    // Then
    let hasKey = defaults.has(.arrayOfIntegersKey)
    #expect(hasKey)

    let actual = defaults.get(for: .arrayOfIntegersKey)
    #expect(expected == actual)
  }

  @Test func testClear() {
    // Given
    let defaults = Defaults()
    let integers: [Int] = [1, 2, 3, 4]
    let expected: [Int]? = nil

    // When
    defaults.set(integers, for: .arrayOfIntegersKey)

    // Then
    defaults.clear(.arrayOfIntegersKey)

    let actual = defaults.get(for: .arrayOfIntegersKey)
    #expect(expected == actual)
  }

  @Test func testSetStruct() {
    let defaults = Defaults()
    let expected: PersonMock = .init(
      name: "Bonnie Greenwell",
      age: 80,
      children: [
        .init(
          name: "Anne Greenwell",
          age: 30,
          children: []
        ),
      ]
    )

    // When
    defaults.set(expected, for: .personMockKey)

    // Then
    let hasKey = defaults.has(.personMockKey)
    #expect(hasKey)

    let actual = defaults.get(for: .personMockKey)
    #expect(expected == actual)
  }
}
