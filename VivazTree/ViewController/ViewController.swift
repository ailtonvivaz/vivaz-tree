//
//  ViewController.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 28/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import ARKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var sceneView: ARSCNView!

    var videoNode: SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        resetTrackingConfiguration()

//        let family = Model.shared.family
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }

    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
//        let referenceImage = imageAnchor.referenceImage
//        let imageName = referenceImage.name ?? "no name"
//        print(imageName)

        let width: CGFloat = 3 //referenceImage.physicalSize.width
        let height: CGFloat = width / 1.78 //referenceImage.physicalSize.height

//        let cardNode = CardNode(card: Card(image: imageName), width: width, height: height)
//        cardNode.eulerAngles.x = -.pi / 2
//        node.addChildNode(cardNode)

        if self.videoNode != nil { return }

        // Get Video URL and create AV Player
        let filePath = Bundle.main.path(forResource: "eu", ofType: "mp4")
        let videoURL = NSURL(fileURLWithPath: filePath!)
        let player = AVPlayer(url: videoURL as URL)

        // Create SceneKit videoNode to hold the spritekit scene.
        let videoNode = SCNNode()

        // Set geometry of the SceneKit node to be a plane, and rotate it to be flat with the image
        videoNode.geometry = SCNPlane(width: width, height: height)
//        videoNode.eulerAngles.z = -.pi / 2
        videoNode.position = SCNVector3(0, 0, 0)

        //Set the video AVPlayer as the contents of the video node's material.
        videoNode.geometry?.firstMaterial?.diffuse.contents = player
        videoNode.geometry?.firstMaterial?.isDoubleSided = true

        let blueMaterial = SCNMaterial()
        blueMaterial.normal.contents = UIColor.blue
        // Alpha transparancy stuff
        let chromaKeyMaterial = ChromaKeyMaterial()
        chromaKeyMaterial.diffuse.contents = player
//        chromaKeyMaterial.displacement.contents = "mae"
//        chromaKeyMaterial.displacement.contentsTransform = SCNMatrix4MakeScale(0.1, 0.1, 0)
//        chromaKeyMaterial.displacement.wrapT = .repeat
//        chromaKeyMaterial.displacement.wrapS = .repeat
        videoNode.geometry!.materials = [blueMaterial]

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

        node.addChildNode(videoNode)

        self.videoNode = videoNode
    }
}
