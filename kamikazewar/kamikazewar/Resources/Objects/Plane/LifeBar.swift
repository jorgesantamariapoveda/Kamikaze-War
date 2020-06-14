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
    private var health: Int = Int.random(in: 3...8)

    // MARK: - Initialization
    init(width: Double = 3) {
        super.init()

        //! ver si me hace falta o no
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
        self.geometry = SCNPlane(width: CGFloat(health), height: 0.01)
        self.geometry?.materials.first?.diffuse.contents = UIColor.green
    }

}

// MARK: - Public functions
extension LifeBar {

    func update(damage: Int) {
        health -= damage
        print("Vida actual:\(health), daño producido:\(damage)")
        if health <= 0 {
            print("MUERE")
            health = 0
        }
        setGeometryAndMaterialNode()
    }

    func getHealth() -> Int {
        return health
    }

}
