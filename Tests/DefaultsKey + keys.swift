//
//  DefaultsKey + keys.swift
//  DefaultsKit
//
//  Created by Nuno Dias on 10/06/2018.
//  Copyright © 2018 Nuno Dias. All rights reserved.
//

import Foundation
@testable import DefaultsKit

extension DefaultsKey {
    static let integerKey = Key<Int>("integerKey")
    static let floatKey = Key<Float>("floatKey")
    static let doubleKey = Key<Double>("doubleKey")
    static let stringKey = Key<String>("stringKey")
    static let boolKey = Key<Bool>("boolKey")
    static let dateKey = Key<Date>("dateKey")
    static let arrayOfIntegersKey = Key<[Int]>("arrayOfIntegersKey")
    static let personMockKey = Key<PersonMock>("personMockKey")
}
