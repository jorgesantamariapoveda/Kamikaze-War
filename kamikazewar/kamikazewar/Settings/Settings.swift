//
//  Settings.swift
//  kamikazewar
//
//  Created by Jorge on 14/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

struct Settings {

    // LifeBar
    static let minLifeBar = 3
    static let maxLifeBar = 3

    // Plane
    static let negativeXaxisValuePlane = -2.5
    static let positiveXaxisValuePlane = 2.5
    static let negativeYaxisValuePlane = -1.5
    static let positiveYaxisValuePlane = 1.5
    static let negativeZaxisValuePlane = -4.0

    static let minDurationAnimationPlane = 10
    static let initialDurationAnimationPlane = 20

    // Ammunition
    static let finiteAmmoSpeed = 3.5
    static let infiniteAmmoSpeed = 8.5

    static let finiteAmmoDamage = 2
    static let infiniteAmmoDamage = 1

    static let numBulletsFinite = 5
}
