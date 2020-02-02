//
//  CardNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 29/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit

class CardNode: SCNNode {
    var card: Card
    
    init(card: Card, width: CGFloat, height: CGFloat) {
        self.card = card
        super.init()
        
        let radius: CGFloat = 0.05 * min(width, height)
        let length: CGFloat = 0.5 * radius
        
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: radius)
        addChildNode(SCNNode(geometry: box))
        
        let plane = SCNPlane(width: width - radius, height: height - radius)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: card.image)
//        material.locksAmbientWithDiffuse = true
//        material.isDoubleSided = false
        material.ambient.contents = UIColor.white
        
        plane.firstMaterial = material
        
//        geometry = plane
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(0, 0, (length / 2) + 0.0001)
        addChildNode(planeNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
