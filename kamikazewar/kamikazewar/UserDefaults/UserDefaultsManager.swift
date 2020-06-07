//
//  UserDefaultsManager.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

final class UserDefaultsManager {

    private static func setHightScore(hightScore: Int) {
        UserDefaults.standard.set(hightScore, forKey: UserDefaults.Keys.hightScore)
    }

    private static func getHightScore() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.Keys.hightScore)
    }

    static func updateHightScore(score: Int) {
        let maxScore = max(score, getHightScore())
        UserDefaultsManager.setHightScore(hightScore: maxScore)
    }

    static func getHightScoreToString() -> String {
        return "Hight Score: \(getHightScore())"
    }
}
