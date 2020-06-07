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

        pauseSessionSceneKit()
    }

    // MARK: - IBActions
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        pauseSessionSceneKit()

        let alertController = UIAlertController(title: "¿Terminar partida?", message: nil, preferredStyle: .alert)

        let alertActionSi = UIAlertAction(title: "SI", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }

        let alertActionNO = UIAlertAction(title: "NO", style: .cancel) { (action) in
            self.runSessionSceneKit()
        }

        alertController.addAction(alertActionSi)
        alertController.addAction(alertActionNO)

        self.present(alertController, animated: true, completion: nil)
    }

}

extension BattleSceneViewController {

    private func setupUI() {
        runSessionSceneKit()
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

    private func runSessionSceneKit() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    private func pauseSessionSceneKit() {
        sceneView.session.pause()
    }
}
