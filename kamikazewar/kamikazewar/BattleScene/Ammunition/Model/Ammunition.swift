//
//  Ammunition.swift
//  kamikazewar
//
//  Created by Jorge on 14/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

final class Ammunition {
    // MARK: - Properties
    private var ammunitionType: AmmunitionType = .infinite
}

// MARK: - Public functions
extension Ammunition {

    func setAmmunitionType(type: AmmunitionType) {
        ammunitionType = type
    }

    func getAmmunitionType() -> AmmunitionType {
        return ammunitionType
    }

}
