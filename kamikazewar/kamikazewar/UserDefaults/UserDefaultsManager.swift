//
//  UserDefaultsManager.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

final class UserDefaultsManager {

    static func sethightScore(hightScore: Int) {
        UserDefaults.standard.set(hightScore, forKey: UserDefaults.Keys.hightScore)
    }

    static func gethightScoreToString() -> String {
        let score = UserDefaults.standard.integer(forKey: UserDefaults.Keys.hightScore)
        return "Hight score: \(score)"
    }
}
