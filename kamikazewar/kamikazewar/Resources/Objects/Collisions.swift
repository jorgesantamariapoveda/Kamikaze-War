//
//  Collisions.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

 struct Collisions: OptionSet {
    let rawValue: Int

    static let plane = Collisions(rawValue: 1 << 0)
    static let bullet = Collisions(rawValue: 1 << 1)
    static let ammoBox = Collisions(rawValue: 1 << 2)
}
