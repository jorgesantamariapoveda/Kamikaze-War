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
    private let ammunitionViewModel: AmmunitionViewModel!

    private let configuration = ARWorldTrackingConfiguration()

    internal var delegate: MainMenuDelegate?

    // MARK: - Initialization
    init() {
        self.scoreViewModel = ScoreViewModel()
        self.ammunitionViewModel = AmmunitionViewModel()

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
        addPlaneToScene()
        addAmmoBoxToScene()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }

    // MARK: - IBActions
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        sceneView.session.pause()

        let alertController = UIAlertController(title: "Finish game?", message: nil, preferredStyle: .alert)

        let alertActionYes = UIAlertAction(title: "YES", style: .default) { (action) in
            self.scoreViewModel.updateHightScore()
            self.delegate?.finishGame()
            self.dismiss(animated: true, completion: nil)
        }

        let alertActionNO = UIAlertAction(title: "NO", style: .cancel) { (action) in
            self.sceneView.session.run(self.configuration)
        }

        alertController.addAction(alertActionYes)
        alertController.addAction(alertActionNO)

        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func infiniteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        setAmmunitionType(type: .infinite)
    }

    @IBAction func finiteAmmunitionTapped(_ sender: UITapGestureRecognizer) {
        setAmmunitionType(type: .finite)
    }

    @IBAction func sceneViewTapped(_ sender: UITapGestureRecognizer) {
        addBulletToScene()
        ammunitionViewModel.updateNumBulletsAmmunition()
        updateSelectedAmmunitionUI()
    }
}

// MARK: - Private functions UI
extension BattleSceneViewController {

    private func setupUI() {
        // Ammunition
        setupAmmunitionView(view: infiniteAmmunitionExtView)
        setupAmmunitionView(view: finiteAmmunitionExtView)
        updateSelectedAmmunitionUI()
        // Score
        updateScoreUI()
    }

    private func setupAmmunitionView(view: UIView) {
        view.layer.cornerRadius = infiniteAmmunitionIntView.frame.width * 0.5
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
    }

    private func updateSelectedAmmunitionUI() {
        finiteAmmunitionLabel.text = ammunitionViewModel.getNumBulletsAmmunition()
        finiteAmmunitionExtView.layer.borderColor = AmmunitionType.finite.color.cgColor
        infiniteAmmunitionExtView.layer.borderColor = AmmunitionType.finite.color.cgColor
    }

    private func updateScoreUI() {
        self.scoreViewModel.updateScore()
        scoreLabel.text = scoreViewModel.getScoreToString()
    }
}

// MARK: - Private functions ammunition
extension BattleSceneViewController {

    private func setAmmunitionType(type: AmmunitionType) {
        ammunitionViewModel.setAmmunitionType(type: type)
        updateSelectedAmmunitionUI()
    }

    private func resetAmmunitionType() {
        ammunitionViewModel.resetNumBulletsAmmunition()
        ammunitionViewModel.setAmmunitionType(type: .infinite)
        updateSelectedAmmunitionUI()
    }
}

// MARK: - Private functions sceneView
extension BattleSceneViewController {

    private func configureSceneView() {
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
    }
}

// MARK: - Private functions SCNNode
extension BattleSceneViewController {

    private func addAmmoBoxToScene() {
        let ammoBox = AmmoBox()
        sceneView.scene.rootNode.addChildNode(ammoBox)
    }

    private func addPlaneToScene() {
        let plane = Plane(durationAnimation: scoreViewModel.getDurationAnimation())
        sceneView.scene.rootNode.addChildNode(plane)
    }

    private func addBulletToScene() {
        guard let camera = self.sceneView.session.currentFrame?.camera else {
            return
        }

        let bullet = Bullet(
                    camera,
                    color: ammunitionViewModel.getBulletColor(),
                    velocity: ammunitionViewModel.getBulletVelocity())
        sceneView.scene.rootNode.addChildNode(bullet)
    }
}

// MARK: - ARSessionDelegate
extension BattleSceneViewController: ARSessionDelegate {

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard
            let planeNode = sceneView.scene.rootNode.childNode(withName: "plane", recursively: true),
            let plane = planeNode as? Plane else {
            return
        }

        // con esto está hecho en bilboard
        if let cameraOrientation = session.currentFrame?.camera.transform {
            plane.face(to: cameraOrientation)
        }

        print(plane.position.z)

        if plane.position.z == 0 {
            sceneView.session.pause()

            let alertController = UIAlertController(title: "👾GAME OVER👾", message: nil, preferredStyle: .alert)

            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.delegate?.finishGame()
                self.dismiss(animated: true, completion: nil)
            }

            alertController.addAction(alertAction)

            if self.presentedViewController == nil {
                self.present(alertController, animated: true, completion: nil)
            }
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

            Explossion.show(with: node, in: sceneView.scene)

            guard let plane = node as? Plane else {
                return
            }

            plane.setDamage(damage: ammunitionViewModel.getBulletDamage())

            if plane.getHealth() == 0 {
                plane.removeFromParentNode()
                addPlaneToScene()

                DispatchQueue.main.async { [weak self] in
                    self?.updateScoreUI()
                }
            }
        } else if contact.nodeA.physicsBody?.categoryBitMask == Collisions.ammoBox.rawValue ||
            contact.nodeB.physicsBody?.categoryBitMask == Collisions.ammoBox.rawValue {

            var node: SCNNode!
            if contact.nodeA is AmmoBox { node = contact.nodeA }
            if contact.nodeB is AmmoBox { node = contact.nodeB }

            Explossion.show(with: node, in: sceneView.scene)

            resetAmmunitionType()

            DispatchQueue.main.async { [weak self] in
                self?.updateSelectedAmmunitionUI()
            }
        }
    }

}
