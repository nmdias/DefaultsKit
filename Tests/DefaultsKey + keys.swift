//
//  DefaultsKey + keys.swift
//
//  Copyright (c) 2017 - 2024 Nuno Manuel Dias
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

extension DefaultsKey {
  static var integerKey: Key<Int> { Key("integerKey") }
  static var floatKey: Key<Float> { Key("floatKey") }
  static var doubleKey: Key<Double> { Key("doubleKey") }
  static var stringKey: Key<String> { Key("stringKey") }
  static var boolKey: Key<Bool> { Key("boolKey") }
  static var dateKey: Key<Date> { Key("dateKey") }
  static var enumKey: Key<EnumMock> { Key("enumKey") }
  static var optionSetKey: Key<OptionSetMock> { Key("optionSetKey") }
  static var arrayOfIntegersKey: Key<[Int]> { Key("arrayOfIntegersKey") }
  static var personMockKey: Key<PersonMock> { Key("personMockKey") }
}
