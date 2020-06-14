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
            return 3
        case .infinite:
            return 9
        }
    }

    var damage: Int {
        switch self {
        case .finite:
            return 2
        case .infinite:
            return 1
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
