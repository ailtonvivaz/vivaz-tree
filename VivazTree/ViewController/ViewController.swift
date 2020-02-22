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

    var hologramNode: HologramNode?

    var videos: [HologramVideo] = [.intro, .presentation, .start, .instructions]
    var videoIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        resetTrackingConfiguration()

        sceneView.showsStatistics = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))

        //Add recognizer to sceneview
        sceneView.addGestureRecognizer(tap)
//        sceneView.debugOptions = [.showBoundingBoxes, .showPhysicsFields]
    }

    //Method called when tap
    @objc func handleTap(rec: UITapGestureRecognizer) {
        if rec.state == .ended {
            let location: CGPoint = rec.location(in: sceneView)
            let hits = sceneView.hitTest(location, options: nil)
            if !hits.isEmpty {
                if let node = hits.first?.node.firstParent(of: Tappable.self) {
                     node.onTap()
                }
            }
        }
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

    func loadTree() {
        guard let hologramNode = self.hologramNode else { return }

        // MARK: - TreeNode

        let treeNode = TreeNode(Model.shared.person)
        hologramNode.addChildNode(treeNode)
        treeNode.position.y = hologramNode.boundingBox.max.y + treeNode.height
    }

    @IBAction func tapNext(_ sender: Any) {
        if videoIndex == -1 {
            videoIndex += 1
            hologramNode?.start()
            loadTree()
        } else if videos.count > videoIndex {
            if videoIndex == 2 {}
            videoIndex += 1
            hologramNode?.video = videos[videoIndex]
        }
    }

    @IBAction func tapWait(_ sender: Any) {
        hologramNode?.video = .waiting
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        let imageName = referenceImage.name ?? "no name"
        print(imageName)

        if imageName == "eye" {
            // MARK: - HologramNode

            if self.hologramNode != nil { return }
            let hologramNode = HologramNode(height: 1.75)

            node.addChildNode(hologramNode)
            self.hologramNode = hologramNode

        } else {
            // MARK: - CardNode

            let width: CGFloat = referenceImage.physicalSize.width
            let height: CGFloat = referenceImage.physicalSize.height

            let cardNode = CardNode(card: Card(image: "Photos/\(imageName)", tree: true), width: width, height: height, show: false) { [weak self] in
                if let vc = self {
                    vc.sceneView.session.remove(anchor: imageAnchor)
                }
            }
            cardNode.eulerAngles.x = -.pi / 2
            node.addChildNode(cardNode)
        }
    }
}
