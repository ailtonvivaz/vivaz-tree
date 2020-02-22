//
//  CardNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 29/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import AVFoundation
import SceneKit

class CardNode: SCNNode, Tappable {
    static var sample: CardNode { CardNode(card: .sample) }
    var card: Card
    var onFinish: () -> Void
    
    private var sphereNode: SCNNode!
    private var boxNode: SCNNode!
    private var planeNode: SCNNode!
    private var player: AVPlayer?
    
    private var showing: Bool = false
    
    private var timer: Timer?
    
    init(card: Card, width: CGFloat = 0.05, height: CGFloat = 0.05, show: Bool = true, onFinish: @escaping () -> Void = {}) {
        self.card = card
        self.onFinish = onFinish
        super.init()
        
        let minSide = min(width, height)
        let radius: CGFloat = 0.05 * minSide
        let length: CGFloat = 0.1 * minSide
        
        let sphere = SCNSphere(radius: 0.1 * minSide)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.black
        sphereMaterial.reflective.contents = UIColor(red: 0, green: 0.764, blue: 1, alpha: 1)
        sphereMaterial.reflective.intensity = 3
        sphereMaterial.transparent.contents = UIColor.black.withAlphaComponent(0.5)
        sphereMaterial.transparencyMode = .default
        sphereMaterial.fresnelExponent = 4
        
        sphere.materials = [sphereMaterial]
        
//        let sphereMaterial = SCNMaterial()
//        sphereMaterial.diffuse.contents = UIColor.blue.withAlphaComponent(0.2)
//        sphere.firstMaterial = sphereMaterial
        self.sphereNode = SCNNode(geometry: sphere)
        addChildNode(sphereNode)
        
        sphereNode.runAction(.repeatForever(.sequence([
            .scale(to: 1.5, duration: 0.5),
            .scale(to: 1.0, duration: 0.5)
        ])))
        
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: radius)
        self.boxNode = SCNNode(geometry: box)
        
        let plane = SCNPlane(width: width - 2 * radius, height: height - 2 * radius)
        let material = SCNMaterial()
        
        if card.tree, let filePath = Bundle.main.path(forResource: card.videoName, ofType: "mov") {
            let url = URL(fileURLWithPath: filePath)
            let player = AVPlayer(url: url)
            material.diffuse.contents = player
            self.player = player
            
        } else {
            material.diffuse.contents = UIImage(named: card.image)
            material.ambient.contents = UIColor.white
        }
        
        plane.firstMaterial = material
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(0, 0, (length / 2) + 0.0001)
        self.planeNode = planeNode
        
        if show {
            self.show()
        }
    }
    
    private func show() {
        sphereNode.removeFromParentNode()
        addChildNode(boxNode)
        addChildNode(planeNode)
        
        if let player = self.player {
            DispatchQueue.main.async {
                player.seek(to: CMTime.zero)
                player.play()
            }
            
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                NotificationCenter.default.removeObserver(self)
                self.onFinish()
            }
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                self.onFinish()
            }
        }
        
        showing = true
    }
    
    func onTap() {
        print("onTap")
        if showing {
            player?.replaceCurrentItem(with: nil)
            onFinish()
            timer?.invalidate()
        } else {
            show()
        }
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
