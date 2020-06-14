//
//  AmmoBox.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import SceneKit

final class AmmoBox: SCNNode {

    private let size: CGFloat = 0.1

    override init() {
        super.init()

        // geometría y material
        self.geometry = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        self.geometry?.materials.first?.diffuse.contents = UIImage(named: "cajaMadera.png")

        // añadir físicas
        if let geometry = self.geometry {
            let shape = SCNPhysicsShape(geometry: geometry, options: nil)
            self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
            self.physicsBody?.isAffectedByGravity = false
            // identificador de nuestro objeto para las colisiones
            self.physicsBody?.categoryBitMask = Collisions.ammoBox.rawValue
            // especificamos los objetos contra los que puede colisionar
            self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue
        }

        //! truco que se me ha ocurrido para que no se viese el hueco interior, me imagino que
        //! habrá algo más elegante pero no he encontrado nada en Internet.
        let nodeBoxFill = AmmoBoxFill(size: size - 0.01)
        nodeBoxFill.position = SCNVector3(0, 0, 0)
        self.addChildNode(nodeBoxFill)

        // posición
        self.position = SCNVector3(-0.5, 0, -1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
