//
//  MainMenuViewController.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private functions
    private func setupUI() {
        self.view.backgroundColor = .black

        startGameButton.layer.cornerRadius = 8.0
    }

    // MARK: - IBActions
    @IBAction func startGameTapped(_ sender: UIButton) {
    }

}
