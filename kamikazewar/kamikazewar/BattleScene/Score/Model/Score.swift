//
//  Score.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import Foundation

final class Score {

    // MARK: - Properties
    private var score: Int = 0

    // MARK: - Public functions
    func updateScore() {
        score += 1
    }

    func getScore() -> Int {
        return score
    }

}
