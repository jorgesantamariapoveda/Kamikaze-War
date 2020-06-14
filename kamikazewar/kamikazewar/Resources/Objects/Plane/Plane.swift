//
//  Plane.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

final class Plane: SCNNode {

    private var lifeBar: LifeBar = LifeBar(health: Int.random(in: 1...10))

    // MARK: - Initialization
    init(durationAnimation: Int) {
        super.init()

        self.name = "plane"
        
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
        let z = -5.0
        self.position = SCNVector3(x, y, z)

//        // mover hacia la cámara
//        let moveToCamera = SCNAction.move(to: SCNVector3(0, 0, 0), duration: Double(durationAnimation))
//        self.runAction(moveToCamera)
//
        self.addChildNode(node)

        // barra de vida
        lifeBar.position = SCNVector3(0, 0.2, 0)
        node.addChildNode(lifeBar)
        //self.addChildNode(lifeBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

// MARK: - Public functions
extension Plane {

    func face(to objectOrientation: simd_float4x4) {
        var transform = objectOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }

    func getHealth() -> Int {
        return lifeBar.getHealth()
    }

    func setDamage(damage: Int) {
        lifeBar.update(damage: damage)
    }

}
