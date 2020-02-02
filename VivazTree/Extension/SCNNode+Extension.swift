//
//  SCNNode+Extension.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 02/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit

extension SCNNode {
    var width: Float { boundingBox.max.x - boundingBox.min.x }
    var height: Float { boundingBox.max.y - boundingBox.min.y }
    var length: Float { boundingBox.max.z - boundingBox.min.z }

    var centerX: Float { (boundingBox.max.x + boundingBox.min.x) / 2 }
}
