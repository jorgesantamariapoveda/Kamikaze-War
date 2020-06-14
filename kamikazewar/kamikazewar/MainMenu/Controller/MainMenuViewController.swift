//
//  MainMenuViewController.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - IBActions
    @IBAction func startGameTapped(_ sender: UIButton) {
        let battleSceneVC = BattleSceneViewController()
        battleSceneVC.delegate = self
        battleSceneVC.modalTransitionStyle = .crossDissolve
        self.present(battleSceneVC, animated: true, completion: nil)
    }
}

// MARK: - Private functions
extension MainMenuViewController {

    private func setupUI() {
        self.view.backgroundColor = .black
        startGameButton.layer.cornerRadius = 8.0

        getHighScore()
    }

    private func getHighScore() {
        scoreLabel.text = UserDefaultsManager.getHightScoreToString()
    }
}

// MARK: - MainMenuDelegate
extension MainMenuViewController: BattleSceneDelegate {

    func finishGame() {
        getHighScore()
    }

}
