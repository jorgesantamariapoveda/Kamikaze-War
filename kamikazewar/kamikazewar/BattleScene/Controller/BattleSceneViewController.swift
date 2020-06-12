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
    @IBOutlet weak var sceneView: ARSCNView!

    @IBOutlet weak var exitButton: UIButton!

    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var infiniteAmmunitionExtView: UIView!
    @IBOutlet weak var infiniteAmmunitionIntView: UIView!

    @IBOutlet weak var finiteAmmunitionExtView: UIView!
    @IBOutlet weak var finiteAmmunitionIntView: UIView!
    @IBOutlet weak var finiteAmmunitionLabel: UILabel!

    private let scoreViewModel: ScoreViewModel!
    private let ammoBox: AmmoBox!

    init(scoreViewModel: ScoreViewModel) {
        self.scoreViewModel = scoreViewModel
        self.ammoBox = AmmoBox()
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            self.updateHightScore()
            self.dismiss(animated: true, completion: nil)
        }

        let alertActionNO = UIAlertAction(title: "NO", style: .cancel) { (action) in
            self.runSessionSceneKit()
        }

        alertController.addAction(alertActionSi)
        alertController.addAction(alertActionNO)

        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func infiniteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        print("Munición infinita")
        infiniteAmmunitionExtView.layer.borderColor = UIColor.systemPink.cgColor
        infiniteAmmunitionExtView.layer.borderWidth = 2
        finiteAmmunitionExtView.layer.borderColor = UIColor.black.cgColor
        finiteAmmunitionExtView.layer.borderWidth = 0
    }

    @IBAction func finiteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        print("FINITA")
        finiteAmmunitionExtView.layer.borderColor = UIColor.systemPink.cgColor
        finiteAmmunitionExtView.layer.borderWidth = 2
        infiniteAmmunitionExtView.layer.borderColor = UIColor.black.cgColor
        infiniteAmmunitionExtView.layer.borderWidth = 0
    }

    @IBAction func sceneViewTapped(_ sender: UITapGestureRecognizer) {
        print("Toco escena")
    }
}

// MARK: - Private functions
extension BattleSceneViewController {

    private func setupUI() {
        infiniteAmmunitionIntView.layer.cornerRadius = infiniteAmmunitionIntView.frame.width * 0.5
        infiniteAmmunitionExtView.layer.cornerRadius = 8
        infiniteAmmunitionExtView.layer.borderWidth = 2
        infiniteAmmunitionExtView.layer.borderColor = UIColor.systemPink.cgColor

        finiteAmmunitionIntView.layer.cornerRadius = infiniteAmmunitionIntView.frame.width * 0.5
        finiteAmmunitionExtView.layer.cornerRadius = 8
        finiteAmmunitionExtView.layer.borderColor = UIColor.black.cgColor
        finiteAmmunitionExtView.layer.borderWidth = 0

        finiteAmmunitionLabel.text = "20"

        configureSceneView()
    }

    private func configureSceneView() {
        appendAmmoBox()
        runSessionSceneKit()
        sceneView.session.delegate = self

//        let ammoBox = AmmoBox()



//        if let camera = self.sceneView.session.currentFrame?.camera {
//            let ammoBox = AmmoBox(camera)
//            sceneView.scene.rootNode.addChildNode(ammoBox)
//        }

        //! revisar
        //sceneView.session.delegate = self

        // tenemos que indicar que se nos avise cuando haya un contacto
        //! revisar
        //sceneView.scene.physicsWorld.contactDelegate = self
    }

    private func appendAmmoBox() {
        sceneView.scene.rootNode.addChildNode(ammoBox)
    }

    private func setupData() {
        scoreLabel.text = scoreViewModel.getScoreToString()
    }

    private func updateScore() {
        self.scoreViewModel.updateScore()
    }

    private func updateHightScore() {
        self.scoreViewModel.updateHightScore()
    }

    private func runSessionSceneKit() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    private func pauseSessionSceneKit() {
        sceneView.session.pause()
    }
}

// MARK: - ARSessionDelegate
extension BattleSceneViewController: ARSessionDelegate {

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // con esto está hecho en bilboard
//        if let cameraOrientation = session.currentFrame?.camera.transform {
//            self.planes.forEach { $0.face(to: cameraOrientation) }
//        }
    }

}
