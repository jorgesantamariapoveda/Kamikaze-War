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

    func updateNumBulletsAmmunition() {
        let type = ammunition.getAmmunitionType()
        switch type {
        case .finite:
            if numBulletsFinite > 0 {
                numBulletsFinite -= 1
            }
            break
        case .infinite:
            break
        }
    }

    func resetNumBulletsAmmunition() {
        let type = ammunition.getAmmunitionType()
        switch type {
        case .finite:
            numBulletsFinite = numBulletsFiniteByDefecte
            break
        case .infinite:
            break
        }
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

}
