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

    init(initialVideo: String) {
        video = initialVideo
        super.init()

        let filePath = Bundle.main.path(forResource: initialVideo, ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        let player = AVPlayer(url: videoURL as URL)
        
        let width: CGFloat = 0.5
        let height: CGFloat = 0.5625 * width

        // Set geometry of the SceneKit node to be a plane, and rotate it to be flat with the image
        let plane = SCNPlane(width: width, height: height)
        geometry = plane
        position.y = Float(width / 2) // SCNVector3(0, height / 2, 0)
//        videoNode.eulerAngles = SCNVector3(0, 0, -CGFloat.pi / 2)

        //Set the video AVPlayer as the contents of the video node's material.
//        geometry?.firstMaterial?.diffuse.contents = player
//        geometry?.firstMaterial?.isDoubleSided = true

        // Alpha transparancy stuff
        let material = HologramMaterial()
        material.diffuse.contents = player

        material.reflective.contents = UIColor(red: 0, green: 0.764, blue: 1, alpha: 1)
        material.reflective.intensity = 3
//        material.transparent.contents = UIColor.black.withAlphaComponent(0.3)
        material.transparencyMode = .default
        material.fresnelExponent = 40

        geometry!.materials = [material]

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
