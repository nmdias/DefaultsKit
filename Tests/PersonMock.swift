//
//  PersonMock.swift
//  DefaultsKit
//
//  Created by Nuno Dias on 10/06/2018.
//  Copyright © 2018 Nuno Dias. All rights reserved.
//

import Foundation

struct PersonMock: Codable {
    let name: String
    let age: Int
    let children: [PersonMock]
}
