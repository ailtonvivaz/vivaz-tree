//
//  TreeNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 02/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit

class TreeNode: SCNNode {
    let person: Person
    
    init(person: Person) {
        self.person = person
        super.init()
        
        let cardwidth: CGFloat = 0.2
        let cardHeight: CGFloat = 0.2
        
        let spacing: CGFloat = 0.2
        let offset = Float((cardwidth + spacing) / 2)
        
        let even = person.partnersCount % 2 == 0
        
        let node = CardNode(person)
        addChildNode(node)
        
        if even {
            node.position.x = Float(-((cardwidth + spacing) / 2))
        }
        
        print(person.name)
        
        for (i, family) in person.families.enumerated() {
            print(family.childrenCount)
//            for (i, partner) in Array(family.partners.filter({ $0 != person })).enumerated() {
//                let node = CardNode.sample
//                addChildNode(node)
//                print(i)
//
//                if even {
//                    let iEven = i % 2 == 0
//                    if iEven {
//                        node.position.x = (offset * Float(i + 1))
//                    } else {
//                        node.position.x = (-offset * Float(i + 2))
//                    }
//                } else {
            ////                    node.position.x =
//                }
//            }
            
            let childrenWidth = cardwidth * CGFloat(family.childrenCount) + spacing * CGFloat(family.childrenCount - 1)
            
            let childrenNode = SCNNode()
            childrenNode.position.y = -Float(cardHeight + spacing)
            childrenNode.position.x = -Float(childrenWidth / 2)
            addChildNode(childrenNode)
            
            for (i, child) in family.children.sorted(by: { $0.birthdate < $1.birthdate }).enumerated() {
                let childTreeNode = TreeNode(person: child)
                childTreeNode.position.x = Float(CGFloat(i) * (cardwidth + spacing))
                childrenNode.addChildNode(childTreeNode)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
