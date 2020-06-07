//
//  Plane.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

final class Plane: SCNNode {

    // MARK: - Initialization
    override init() {
        super.init()

        let plane = SCNScene(named: "ship.scn") ?? SCNScene()
        let node = plane.rootNode
        self.addChildNode(node)

        // añadir físicas
        let shape = SCNPhysicsShape(node: node, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false

        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.plane.rawValue

        // especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.bullet.rawValue

        // animar el avion un poco
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let hoverForever = SCNAction.repeatForever(hoverSequence)
        self.runAction(hoverForever)
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

}
