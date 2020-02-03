//
//  HologramNode.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 02/02/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import AVFoundation
import SceneKit

enum HologramVideo: String {
    case intro
    case presentation
    case start
    case instructions
    case waitingNoSong = "waiting_no_song"
    case waiting

    var url: URL {
        let filePath = Bundle.main.path(forResource: rawValue, ofType: "mp4")!
        return URL(fileURLWithPath: filePath)
    }
}

class HologramNode: SCNNode {
    var video: HologramVideo = .intro {
        didSet {
            didSetVideo()
        }
    }

    private var player: AVPlayer!
    private let material = HologramMaterial()
    private var personHeight: CGFloat = 0

//    private var player: AVPlayer

    init(height: CGFloat) {
        super.init()
        self.personHeight = height

        // MARK: - PedestalNode

        let url = Bundle.main.url(forResource: "tech_pedestal", withExtension: "usdz")!
        let pedestalNode = SCNReferenceNode(url: url)!
        pedestalNode.load()
        let scale = height / 40
        pedestalNode.scale = SCNVector3(scale, scale, scale)
        addChildNode(pedestalNode)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didSetVideo() {
        player = AVPlayer(url: video.url)
        material.diffuse.contents = player
        DispatchQueue.main.async {
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            NotificationCenter.default.removeObserver(self)
            self.loopingWaiting()
        }
    }

    func start() {
        let width: CGFloat = personHeight / 1.7778

        // Set geometry of the SceneKit node to be a plane, and rotate it to be flat with the image
        let plane = SCNPlane(width: personHeight, height: width)
        let videoNode = SCNNode(geometry: plane)
        addChildNode(videoNode)
        videoNode.position.y = Float(personHeight / 2) + Float(height / 25)
        videoNode.eulerAngles.z = -.pi / 2

        plane.materials = [material]

        video = .intro
    }

    private func loopingWaiting() {
        player = AVPlayer(url: HologramVideo.waitingNoSong.url)
        material.diffuse.contents = player
        DispatchQueue.main.async {
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }
    }
}
