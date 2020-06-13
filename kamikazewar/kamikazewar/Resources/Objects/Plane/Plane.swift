//
//  Plane.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

final class Plane: SCNNode {

    let lifeBar: LifeBar!

    // MARK: - Initialization
    init(speed: Double) {

        // barra de vida
        lifeBar = LifeBar(width: 0.5)
        lifeBar.position = SCNVector3(0, 0.2, 0)

        super.init()

        // geometría y material
        let plane = SCNScene(named: "ship.scn") ?? SCNScene()
        let node = plane.rootNode

        // añadir físicas
        let shape = SCNPhysicsShape(node: node, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.plane.rawValue
        // especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue

        // posición
        let x = Double.random(in: -1.25...1.25)
        let y = Double.random(in: -0.75...0.75)
        let z = -15.0
        self.position = SCNVector3(x, y, z)

        let moveToCamara = SCNAction.move(to: SCNVector3(0, 0, 0), duration: 10)
        moveToCamara.speed = CGFloat(speed)
        self.runAction(moveToCamara)

        self.addChildNode(node)
        node.addChildNode(lifeBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Public functions
    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }

    func updateLifeBar() {
        
    }

}
