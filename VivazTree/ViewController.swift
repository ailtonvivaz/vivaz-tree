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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sceneView.delegate = self
        configureLighting()
        resetTrackingConfiguration()
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
//        label.text = "Move camera around to detect images"
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        let imageName = referenceImage.name ?? "no name"
        
//        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
//        let planeNode = SCNNode(geometry: plane)
        ////        planeNode.opacity = 0.80
//        planeNode.eulerAngles.x = -.pi / 2
//
//        print(imageName)
//
        ////        planeNode.runAction(imageHighlightAction)
//
//        node.addChildNode(planeNode)
//        DispatchQueue.main.async {
//            self.label.text = "Image detected: \"\(imageName)\""
//        }
        
//        plane.
        
        let width = referenceImage.physicalSize.width
        let height = referenceImage.physicalSize.height
        let radius = 0.1 * min(width, height)
        let length = radius
        let cubeNode = SCNNode(geometry: SCNBox(width: width, height: height, length: length, chamferRadius: radius))
        cubeNode.position = SCNVector3(0, 0, 0) // SceneKit/AR coordinates are in meters
//        cubeNode.mate
        cubeNode.eulerAngles.x = .pi / 2
//        cubeNode.bac
        node.addChildNode(cubeNode)
        
        let plane = SCNPlane(width: width - radius, height: height - radius)
        let material = SCNMaterial()
        material.diffuse.contents = imageName
        material.locksAmbientWithDiffuse = true
        material.isDoubleSided = false
        material.ambient.contents = UIColor.white
        
        plane.firstMaterial = material
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(0, length, 0)

        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
    }
}
