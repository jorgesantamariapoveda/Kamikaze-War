//
//  LifeBar.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

final class LifeBar: SCNNode {

    // MARK: - Properties
    var health: Int = 3

    // MARK: - Initialization
    init(width: Double = 3) {
        super.init()

        //! ver si me hace falta o no
        self.name = "lifeBar"

        setGeometryAndMaterialNode(width: width)

        // posición
        self.position = SCNVector3(0, 0, 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func setGeometryAndMaterialNode(width: Double) {
        let geometry = SCNPlane(width: CGFloat(width), height: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        geometry.materials = [material]
        self.geometry = geometry
    }
}

// MARK: - Public functions
extension LifeBar {

    func update(damage: Int) {
        self.health -= damage
        if self.health <= 0 {
            self.health = 0
        }
        setGeometryAndMaterialNode(width: Double(self.health))
    }

    func getHealth() -> Int {
        return health
    }

}
