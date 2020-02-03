//
//  HologramNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 02/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit
import AVFoundation

class HologramNode: SCNNode {
    var video: String { didSet {} }

//    private var player: AVPlayer

    init(initialVideo: String, height: CGFloat) {
        video = initialVideo
        super.init()

        // MARK: - PedestalNode

        let url = Bundle.main.url(forResource: "tech_pedestal", withExtension: "usdz")!
        let pedestalNode = SCNReferenceNode(url: url)!
        pedestalNode.load()
        let scale = height / 40
        pedestalNode.scale = SCNVector3(scale, scale, scale)
        addChildNode(pedestalNode)

        let filePath = Bundle.main.path(forResource: initialVideo, ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        let player = AVPlayer(url: videoURL as URL)
        
        let width: CGFloat = height / 1.7778

        // Set geometry of the SceneKit node to be a plane, and rotate it to be flat with the image
        let plane = SCNPlane(width: height, height: width)
        let videoNode = SCNNode(geometry: plane)
        addChildNode(videoNode)
        videoNode.position.y = Float(height / 2) + Float(height / 25)
        videoNode.eulerAngles.z = -.pi / 2

        // Alpha transparancy stuff
        let material = HologramMaterial()
        material.diffuse.contents = player

        plane.materials = [material]

        //video does not start without delaying the player
        //playing the video before just results in [SceneKit] Error: Cannot get pixel buffer (CVPixelBufferRef)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            player.seek(to: CMTimeMakeWithSeconds(1, preferredTimescale: 1000))
            player.play()
        }

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didSetVideo() {
        
    }
}
