//
//  AmmoBox.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

final class AmmoBox: SCNNode {

    private let sizeBox: CGFloat = 0.1

    override init() {
        super.init()

        // geometría y material
        let box = SCNBox(
                    width: sizeBox,
                    height: sizeBox,
                    length: sizeBox,
                    chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "cajaMadera.png")
        box.materials = [material]
        self.geometry = box

        // añadir físicas
        let shape = SCNPhysicsShape(node: self, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.ammoBox.rawValue
        // especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue

        //! truco que se me ha ocurrido para que no se viese el hueco interior, me imagino que
        //! habrá algo más elegante.
        appendBoxFill()

        // posición
        self.position = SCNVector3(-0.5, 0, -1)
    }

    private func appendBoxFill() {
        let sizeBoxFill = sizeBox - 0.01
        let boxFill = SCNBox(
                        width: sizeBoxFill,
                        height: sizeBoxFill,
                        length: sizeBoxFill,
                        chamferRadius: 0.0)

        let materialBoxFill = SCNMaterial()
        materialBoxFill.diffuse.contents = UIColor.black
        boxFill.materials = [materialBoxFill]

        let nodeBoxFill = SCNNode(geometry: boxFill)
        nodeBoxFill.position = SCNVector3(0, 0, 0)

        self.addChildNode(nodeBoxFill)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
