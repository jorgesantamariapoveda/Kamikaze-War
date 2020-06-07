//
//  BattleSceneViewController.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

final class BattleSceneViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        sceneView.session.pause()
    }

    // MARK: - IBActions
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension BattleSceneViewController {

    private func setupUI() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        //! revisar
        //sceneView.session.delegate = self

        // tenemos que indicar que se nos avise cuando haya un contacto
        //! revisar
        //sceneView.scene.physicsWorld.contactDelegate = self
    }

    private func setupData() {
        updateScore()
    }

    private func updateScore() {

    }
}
