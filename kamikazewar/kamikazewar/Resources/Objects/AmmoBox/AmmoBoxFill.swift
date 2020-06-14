//
//  AmmoBoxFill.swift
//  kamikazewar
//
//  Created by Jorge on 14/06/2020.
//  Copyright © 2020 Jorge. All rights reserved.
//

import SceneKit

final class AmmoBoxFill: SCNNode {

    init(size: CGFloat) {
        super.init()

        self.geometry = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        self.geometry?.materials.first?.diffuse.contents = UIColor(red: 163/266, green: 119/266, blue: 86/266, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
