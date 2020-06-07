//
//  File.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

final class Bullet: SCNNode {
    
    // MARK: - Properties
    private let velocity: Float = 9

    // MARK: - Initialization
    init(_ camera: ARCamera) {
        super.init()

        let bullet = SCNSphere(radius: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemPink
        bullet.materials = [material]

        self.geometry = bullet

        // añadir físicas
        let shape = SCNPhysicsShape(geometry: bullet, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false

        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.bullet.rawValue

        // especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.plane.rawValue

        // aplicamos un impulso a la bala
        let matrix = SCNMatrix4(camera.transform)
        // vector director (que también lleva la velocidad)
        let v = -self.velocity
        let direccion = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        // necesitamos un punto de origen
        let position = SCNVector3(matrix.m41, matrix.m42, matrix.m43)

        self.physicsBody?.applyForce(direccion, asImpulse: true)
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
