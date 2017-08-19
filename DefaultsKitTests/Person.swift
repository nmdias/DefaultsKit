//
//  Person.swift
//  DefaultsKit
//
//  Created by Nuno Dias on 19/08/2017.
//  Copyright © 2017 Nuno Dias. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let age: Int
    let children: [Person]
}

