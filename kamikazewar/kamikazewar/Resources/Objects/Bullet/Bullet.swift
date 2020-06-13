//
//  File.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

final class Bullet: SCNNode {
    
    // MARK: - Initialization
    init(_ camera: ARCamera, color: UIColor, velocity: Float) {
        super.init()

        // geometría y material
        let geometry = SCNSphere(radius: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = color
        geometry.materials = [material]

        self.geometry = geometry

        // añadir físicas
        let shape = SCNPhysicsShape(geometry: geometry, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        // identificador de nuestro objeto para las colisiones
        self.physicsBody?.categoryBitMask = Collisions.bullet.rawValue
        // especificamos los objetos contra los que puede colisionar
        self.physicsBody?.contactTestBitMask = Collisions.plane.rawValue
        self.physicsBody?.contactTestBitMask = Collisions.ammoBox.rawValue

        // aplicamos un impulso a la bala
        let matrix = SCNMatrix4(camera.transform)
        // vector director (que también lleva la velocidad)
        let v = -velocity
        let direccion = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        // necesitamos un punto de origen
        let position = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
        self.physicsBody?.applyForce(direccion, asImpulse: true)

//        if let sourceAudio = SCNAudioSource(named: "Resources/nice.wav") {
//            sourceAudio.volume = 5
//            sourceAudio.loops = true
//            sourceAudio.load()
//            let player = SCNAudioPlayer(source: sourceAudio)
//            self.addAudioPlayer(player)
////            let playAudioSource = SCNAction.playAudio(sourceAudio, waitForCompletion: true)
////            self.runAction(playAudioSource)
//        }

        // posición
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
