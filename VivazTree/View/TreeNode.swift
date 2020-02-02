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
    
    private let SPACING: Float = 0.01
    
    init(person: Person) {
        self.person = person
        super.init()
        
        let cardHeight: Float = 0.1
        
        if person.familiesCount == 0 {
            let personNode = CardNode(person)
            addChildNode(personNode)
        } else {
            var familyOffset: Float = 0
            for (i, family) in person.familiesSorted.enumerated() {
                print(family.childrenCount)
                
                let partnersNode = SCNNode()
                addChildNode(partnersNode)
                
                var partnersOffset: Float = 0
                
                if i == 0 {
                    let personNode = CardNode(person)
                    partnersNode.addChildNode(personNode)
                    partnersOffset += personNode.width + SPACING
                }
                
                for partner in Array(family.partners.filter { $0 != person }) {
                    let partnerNode = CardNode(partner)
                    partnersNode.addChildNode(partnerNode)
                    partnerNode.position.x = familyOffset + partnersOffset
                    
                    partnersOffset += partnerNode.width + SPACING
                }
                
                let childrenNode = SCNNode()
                if family.childrenCount > 0 {
                    childrenNode.position.x = familyOffset
                    childrenNode.position.y = -Float(cardHeight + SPACING)
                    addChildNode(childrenNode)
                    
                    var offset: Float = 0
                    for child in family.childrenSorted {
                        let childTreeNode = TreeNode(person: child)
                        print(child.name, childTreeNode.width, offset)
                        childTreeNode.position.x = offset
                        offset += childTreeNode.width + SPACING
                        childrenNode.addChildNode(childTreeNode)
                    }
                }
                
                if partnersNode.width > childrenNode.width {
                    childrenNode.position.x = partnersNode.centerX
                } else if partnersNode.width < childrenNode.width {
                    partnersNode.position.x = childrenNode.centerX
                }
                
                familyOffset += max(partnersNode.width, childrenNode.width) + SPACING
            }
        }
        
        position.x = -width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
