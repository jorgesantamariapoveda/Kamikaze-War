//
//  AmmunitionViewModel.swift
//  kamikazewar
//
//  Created by Jorge on 14/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import UIKit

final class AmmunitionViewModel {
    // MARK: - Properties
    private let ammunition: Ammunition
    private var numBulletsFinite: Int
    private let numBulletsFiniteByDefecte = 5

    // MARK: - Initialization
    init() {
        self.ammunition = Ammunition()
        self.numBulletsFinite = numBulletsFiniteByDefecte
    }
}

// MARK: - Public functions
extension AmmunitionViewModel {

    func setAmmunitionType(type: AmmunitionType) {
        switch type {
        case .finite:
            if numBulletsFinite > 0 {
                ammunition.setAmmunitionType(type: type)
            }
            break
        case .infinite:
            ammunition.setAmmunitionType(type: type)
            break
        }
    }

    func getBorderColorTo(type: AmmunitionType) -> CGColor {
        if type == ammunition.getAmmunitionType() {
            return type.color.cgColor
        } else {
            return UIColor.black.cgColor
        }
    }

    func updateNumBulletsAmmunition() {
        let type = ammunition.getAmmunitionType()
        switch type {
        case .finite:
            numBulletsFinite -= 1
            if numBulletsFinite == 0 {
                ammunition.setAmmunitionType(type: .infinite)
            }
            break
        case .infinite:
            break
        }
    }

    func resetNumBulletsAmmunition() {
        numBulletsFinite = numBulletsFiniteByDefecte
    }

    func getNumBulletsAmmunition() -> String {
        return "\(self.numBulletsFinite)"
    }

    func getBulletColor() -> CGColor {
        return ammunition.getAmmunitionType().color.cgColor
    }

    func getBulletVelocity() -> Double {
        return ammunition.getAmmunitionType().velocity
    }

    func getBulletDamage() -> Int {
        return ammunition.getAmmunitionType().damage
    }

    func getBulletSoundName() -> String {
        return ammunition.getAmmunitionType().soundName
    }

}
