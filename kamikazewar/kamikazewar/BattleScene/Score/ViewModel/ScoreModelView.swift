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
    init(score: Score) {
        self.score = score
    }

    // MARK: - Public functions
    func updateScore() {
        self.score.updateScore()
    }

    func getScoreToString() -> String {
        return "Score: \(self.score.getScore())"
    }
}
