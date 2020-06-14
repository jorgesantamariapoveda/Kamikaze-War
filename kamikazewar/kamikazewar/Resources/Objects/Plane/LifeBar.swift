//
//  LifeBar.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

enum ColorLifeBar {
}

final class LifeBar: SCNNode {

    // MARK: - Properties
    private var health: Int
    private let fragmento: Double

    // MARK: - Initialization
    init(health: Int) {
        self.health = health
        self.fragmento = 2 / Double(health)
        super.init()

        self.name = "lifeBar"
        setGeometryAndMaterialNode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private functions
extension LifeBar {

    private func setGeometryAndMaterialNode() {
        self.geometry = SCNPlane(width: CGFloat(Double(health) * fragmento), height: 0.05)
        self.geometry?.materials.first?.diffuse.contents = UIColor.green
    }

}

// MARK: - Public functions
extension LifeBar {

    func update(damage: Int) {
        health -= damage
        if health <= 0 {
            health = 0
        }
        setGeometryAndMaterialNode()
    }

    func getHealth() -> Int {
        return health
    }

}
