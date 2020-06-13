//
//  ScoreModelView.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

final class ScoreViewModel {

    // MARK: - Properties
    private let score: Score

    // MARK: - Initialization
    init() {
        self.score = Score()
    }

    // MARK: - Public functions
    func updateScore() {
        self.score.updateScore()
    }

    func updateHightScore() {
        UserDefaultsManager.updateHightScore(score: score.getScore())
    }

    func getScoreToString() -> String {
        return "Score: \(self.score.getScore())"
    }

    func getPlaneSpeed() -> Double {
        let score = self.score.getScore()
        return min(3, Double(score) + 0.01)
    }
}
