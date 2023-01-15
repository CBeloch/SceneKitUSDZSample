//
//  ViewController.swift
//  SceneKitUSDZSample
//
//  Created by Alexander von Below on 09.01.23.
//

import UIKit
import SceneKit
import ARKit
import SceneKit.ModelIO

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = [
            .init(
                UIImage(named: "robot")!.cgImage!,
                orientation: .up,
                physicalWidth: 0.1 // in meter - SCALE HERE (1 of 2)
            )
        ]
        // ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)!

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Ensure ImageAnchor
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        // Get the detected reference image
//        let referenceImage = imageAnchor.referenceImage
//        referenceImage.name // "robot"
        
        guard
            let modelURL = Bundle.main.url(forResource: "Televisor_00", withExtension: "usdz"),
            let modelNode = SCNReferenceNode(url: modelURL)
        else { return }
        
        modelNode.load()
        
        modelNode.scale = .init(0.002) // SCALE HERE (2 of 2)
        
        node.addChildNode(modelNode)
        
        self.sceneView.prepare([modelNode]) { success in }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
