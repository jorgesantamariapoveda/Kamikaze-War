//
//  AmmoBox.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

final class AmmoBox: SCNNode {

    private let width: CGFloat = 0.05
    private let height: CGFloat = 0.05
    private let length: CGFloat = 0.05
    private let decrementBoxFill: CGFloat = 0.001

    override init() {
        super.init()

        let box = SCNBox(width: width, height: height, length: length, chamferRadius: 0.0)

        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "cajaMadera.png")
        box.materials = [material]

        self.geometry = box
        self.position = SCNVector3(0.02, 0.02, -0.05)

        //! truco que se me ha ocurrido para que no se viese el hueco interior, me imagino que
        //! habrá algo más elegante.
        appendBoxFill()

        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.ammoBox.rawValue
    }

    private func appendBoxFill() {
        let boxFill = SCNBox(
                        width: width - decrementBoxFill,
                        height: height - decrementBoxFill,
                        length: length - decrementBoxFill,
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
