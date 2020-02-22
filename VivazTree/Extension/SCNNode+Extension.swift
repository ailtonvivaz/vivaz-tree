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
    
    var adam: SCNNode? {
        if parent?.parent == nil {
            return self
        } else {
            return parent?.adam
        }
    }
    
    func removeFamilyFromRoot() {
        adam?.removeFromParentNode()
    }
    
    func firstParent<T>(of type: T.Type) -> T? {
        if let node = self as? T {
            return node
        }
        return parent?.firstParent(of: type)
    }
}
