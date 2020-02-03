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
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        let imageName = referenceImage.name ?? "no name"
        print(imageName)

        // MARK: - CardNode

//        let width: CGFloat = referenceImage.physicalSize.width
//        let height: CGFloat = referenceImage.physicalSize.height

//        let cardNode = CardNode(card: Card(image: imageName), width: width, height: height)
//        cardNode.eulerAngles.x = -.pi / 2
//        node.addChildNode(cardNode)

        // MARK: - HologramNode

        if self.hologramNode != nil { return }

        let hologramNode = HologramNode(initialVideo: "presentation", height: 0.5)
//        hologramNode.eulerAngles.z = -.pi / 2
//        hologramNode.position.y = -0.1

        node.addChildNode(hologramNode)
        self.hologramNode = hologramNode

        // MARK: - TreeNode

        let treeNode = TreeNode(Model.shared.person)
        node.addChildNode(treeNode)
        treeNode.position.y = hologramNode.boundingBox.max.x + treeNode.height + 0.1
    }
}
