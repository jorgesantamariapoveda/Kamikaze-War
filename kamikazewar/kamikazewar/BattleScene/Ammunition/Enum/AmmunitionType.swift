//
//  AmmunitionType.swift
//  kamikazewar
//
//  Created by Jorge on 14/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import UIKit

enum AmmunitionType {
    case finite
    case infinite

    var color: UIColor {
        switch self {
        case .finite:
            return .systemBlue
        case .infinite:
            return .systemPink
        }
    }

    var velocity: Double {
        switch self {
        case .finite:
            return Settings.finiteAmmoSpeed
        case .infinite:
            return Settings.infiniteAmmoSpeed
        }
    }

    var damage: Int {
        switch self {
        case .finite:
            return Settings.finiteAmmoDamage
        case .infinite:
            return Settings.infiniteAmmoDamage
        }
    }

    var soundName: String {
        switch self {
        case .finite:
            return "laserX2.mp3"
        case .infinite:
            return "laserX1.mp3"
        }
    }
}
