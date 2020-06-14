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
}

// MARK: - Public functions
extension ScoreViewModel {

    func updateScore() {
        self.score.updateScore()
    }

    func updateHightScore() {
        UserDefaultsManager.updateHightScore(score: score.getScore())
    }

    func getScoreToString() -> String {
        return "Score: \(self.score.getScore())"
    }

    func getDurationAnimation() -> Int {
        let durationAnimationByScore = Settings.initialDurationAnimationPlane - self.score.getScore()
        return max(Settings.minDurationAnimationPlane, durationAnimationByScore)
    }
}
