//
//  LifeBar.swift
//  kamikazewar
//
//  Created by Jorge on 12/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import ARKit

final class LifeBar: SCNNode {

    init(width: Float) {
        super.init()

        // geometría y material
        let geometry = SCNPlane(width: CGFloat(width), height: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        geometry.materials = [material]
        self.geometry = geometry

        // posición
        self.position = SCNVector3(0, 0, 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
