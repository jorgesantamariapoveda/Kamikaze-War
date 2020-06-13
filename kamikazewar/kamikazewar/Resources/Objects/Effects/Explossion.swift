//
//  Explossion.swift
//  ARBillboad
//
//  Created by Jorge on 07/06/2020.
//  Copyright © 2020 Oscar Izquierdo. All rights reserved.
//

import ARKit

struct Explossion {

    // MARK: - Public functions
    static func show(with node: SCNNode, in scene: SCNScene) {
        guard let explossion = SCNParticleSystem(named: "Explossion", inDirectory: nil) else {
            return
        }

        let position = node.position
        let translationMatrix = SCNMatrix4MakeTranslation(position.x, position.y, position.z)

        let rotation = node.rotation
        let rotationMatrix = SCNMatrix4MakeRotation(rotation.w, rotation.x, rotation.y, rotation.z)

        let transformMatrix = SCNMatrix4Mult(rotationMatrix, translationMatrix)

        explossion.emitterShape = node.geometry
        scene.addParticleSystem(explossion, transform: transformMatrix)
    }
}
