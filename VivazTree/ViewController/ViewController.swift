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

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        resetTrackingConfiguration()

        sceneView.showsStatistics = true
//        sceneView.debugOptions = [.showBoundingBoxes, .showPhysicsFields]
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

            let cardNode = CardNode(card: Card(image: imageName), width: width, height: height)
            cardNode.eulerAngles.x = -.pi / 2
            node.addChildNode(cardNode)
        }
    }
}
