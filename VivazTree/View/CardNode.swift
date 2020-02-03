//
//  CardNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 29/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit
import AVFoundation

class CardNode: SCNNode {
    static var sample: CardNode { CardNode(card: .sample) }
    var card: Card
    
    init(card: Card, width: CGFloat = 0.05, height: CGFloat = 0.05) {
        self.card = card
        super.init()
        
        let radius: CGFloat = 0.05 * min(width, height)
        let length: CGFloat = 0.1 * min(width, height)
        
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: radius)
        addChildNode(SCNNode(geometry: box))
        
        let plane = SCNPlane(width: width - 2 * radius, height: height - 2 * radius)
        let material = SCNMaterial()
        
        if card.tree, let filePath = Bundle.main.path(forResource: card.videoName, ofType: "mov") {
            let url = URL(fileURLWithPath: filePath)
            let player = AVPlayer(url: url)
            material.diffuse.contents = player
            DispatchQueue.main.async {
                player.seek(to: CMTime.zero)
                player.play()
            }

            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                NotificationCenter.default.removeObserver(self)
                self.removeFromParentNode()
            }
            
        } else {
            material.diffuse.contents = UIImage(named: card.image)
            material.ambient.contents = UIColor.white
        }
        
        plane.firstMaterial = material
        
//        geometry = plane
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(0, 0, (length / 2) + 0.0001)
        addChildNode(planeNode)
        
        let textNode = createTextNode(string: card.title)
//        textNode.position.x = -textNode.width / 2
        textNode.position.z = Float(length)
//        textNode.position.x = Float(width)
        addChildNode(textNode)
    }
    
    convenience init(_ person: Person, width: CGFloat = 0.05, height: CGFloat = 0.05) {
        self.init(card: Card(image: person.imageName != nil ? "Photos/\(person.imageName!)" : "eu", title: person.name, description: ""), width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTextNode(string: String) -> SCNNode {
        let text = SCNText(string: string, extrusionDepth: 0.05)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        let fontSize = Float(0.003)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)
        
        return textNode
    }
}
