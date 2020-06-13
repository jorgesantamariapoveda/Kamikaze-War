//
//  BattleSceneViewController.swift
//  kamikazewar
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

enum AmmunitionType {
    case finite
    case infinite

    var color: UIColor {
        switch self {
            case .finite:
                return .systemBlue
            case .infinite:
                return .systemPink
        }
    }

    var velocity: Float {
        switch self {
            case .finite:
                return 4
            case .infinite:
                return 8
        }
    }

    var damage: Int {
        switch self {
            case .finite:
                return 2
            case .infinite:
                return 1
        }
    }
}

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

    private let configuration = ARWorldTrackingConfiguration()

    private let scoreViewModel: ScoreViewModel!
    private let ammoBox: AmmoBox!
    private var plane: Plane!
    private var planeSpeed = 1.0
    private var lifeBarPlane = 10

    private var finiteAmountAmmunition = 8
    private var selectedAmmunition = AmmunitionType.infinite

    internal var delegate: MainMenuDelegate?

    init(scoreViewModel: ScoreViewModel) {
        self.scoreViewModel = scoreViewModel
        ammoBox = AmmoBox()
        plane = Plane(speed: planeSpeed)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureSceneView()
        setupData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        sceneView.session.pause()
    }

    // MARK: - IBActions
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        sceneView.session.pause()

        let alertController = UIAlertController(title: "¿Terminar partida?", message: nil, preferredStyle: .alert)

        let alertActionSi = UIAlertAction(title: "SI", style: .default) { (action) in
            self.updateHightScore()
            self.delegate?.finishGame()
            self.dismiss(animated: true, completion: nil)
        }

        let alertActionNO = UIAlertAction(title: "NO", style: .cancel) { (action) in
            self.sceneView.session.run(self.configuration)
        }

        alertController.addAction(alertActionSi)
        alertController.addAction(alertActionNO)

        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func infiniteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        selectedAmmunition = .infinite
        updateSelectedAmmunitionUI()
    }

    @IBAction func finiteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        if finiteAmountAmmunition > 0 {
            selectedAmmunition = .finite
            updateSelectedAmmunitionUI()
        }
    }

    @IBAction func sceneViewTapped(_ sender: UITapGestureRecognizer) {
        guard let camera = self.sceneView.session.currentFrame?.camera else { return }

        let bullet = Bullet(
                    camera,
                    color: selectedAmmunition.color,
                    velocity: selectedAmmunition.velocity)
        sceneView.scene.rootNode.addChildNode(bullet)

        switch selectedAmmunition {
            case .finite:
                finiteAmountAmmunition -= 1
                if finiteAmountAmmunition == 0 {
                    selectedAmmunition = .infinite
                }
                updateFiniteAmmunitionUI()
                updateSelectedAmmunitionUI()
                break
            case .infinite:
                break
        }
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

        updateSelectedAmmunitionUI()

        finiteAmmunitionLabel.text = "20"
    }

    private func updateSelectedAmmunitionUI() {
        switch selectedAmmunition {
            case .finite:
                finiteAmmunitionExtView.layer.borderColor = UIColor.systemPink.cgColor
                finiteAmmunitionExtView.layer.borderWidth = 2
                infiniteAmmunitionExtView.layer.borderColor = UIColor.black.cgColor
                infiniteAmmunitionExtView.layer.borderWidth = 0
                break
            case .infinite:
                infiniteAmmunitionExtView.layer.borderColor = UIColor.systemPink.cgColor
                infiniteAmmunitionExtView.layer.borderWidth = 2
                finiteAmmunitionExtView.layer.borderColor = UIColor.black.cgColor
                finiteAmmunitionExtView.layer.borderWidth = 0
                break
        }
    }

    private func configureSceneView() {
        sceneView.session.run(configuration)
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self

        sceneView.scene.rootNode.addChildNode(ammoBox)
        sceneView.scene.rootNode.addChildNode(plane)
    }

    private func setupData() {
        updateScoreUI()
        updateFiniteAmmunitionUI()
    }

    private func updateScore() {
        self.scoreViewModel.updateScore()
        updateScoreUI()
    }

    private func updateScoreUI() {
        scoreLabel.text = scoreViewModel.getScoreToString()
    }

    private func updateHightScore() {
        self.scoreViewModel.updateHightScore()
    }

    private func updateFiniteAmmunitionUI() {
        finiteAmmunitionLabel.text = "\(finiteAmountAmmunition)"
    }

    private func addNewPlane() {
        let plane = Plane(speed: scoreViewModel.getPlaneSpeed())
        sceneView.scene.rootNode.addChildNode(plane)
    }
}

// MARK: - ARSessionDelegate
extension BattleSceneViewController: ARSessionDelegate {

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // con esto está hecho en bilboard
        if let cameraOrientation = session.currentFrame?.camera.transform {
            plane.face(to: cameraOrientation)
        }
    }

}

// MARK: - SCNPhysicsContactDelegate
extension BattleSceneViewController: SCNPhysicsContactDelegate {

    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // Si algo choca con el avión
        if contact.nodeA.physicsBody?.categoryBitMask == Collisions.plane.rawValue ||
            contact.nodeB.physicsBody?.categoryBitMask == Collisions.plane.rawValue {

            var node: SCNNode!
            if contact.nodeA is Plane { node = contact.nodeA }
            if contact.nodeB is Plane { node = contact.nodeB }

            // Explossion
            Explossion.show(with: node, in: sceneView.scene)

            guard let plane = node as? Plane else {
                return
            }

            plane.updateLifeBar(damage: selectedAmmunition.damage)
            if plane.getHealth() == 0 {
                plane.removeFromParentNode()
                DispatchQueue.main.async { [weak self] in
                    self?.updateScore()
                    self?.updateScoreUI()
                    self?.addNewPlane()
                }
            }
        } else if contact.nodeA.physicsBody?.categoryBitMask == Collisions.ammoBox.rawValue ||
            contact.nodeB.physicsBody?.categoryBitMask == Collisions.ammoBox.rawValue {

            var node: SCNNode!
            if contact.nodeA is AmmoBox { node = contact.nodeA }
            if contact.nodeB is AmmoBox { node = contact.nodeB }

            // Explossion
            Explossion.show(with: node, in: sceneView.scene)

            finiteAmountAmmunition = 8

            DispatchQueue.main.async { [weak self] in
                self?.updateFiniteAmmunitionUI()
            }
        }
    }

}
