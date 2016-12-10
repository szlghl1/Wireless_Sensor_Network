//
//  RGGViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/7.
//  Copyright © 2016 LingHe. All rights reserved.
//

import UIKit
import SceneKit

class RGGViewController: UIViewController {
    @IBOutlet weak var highlightSwitch: UISwitch!
    @IBOutlet weak var sceneView: SCNView!
    
    var graphToDraw:RGG?
    let nodeForLine = SCNNode()//all lines are under this node
    let nodeForOffset = SCNNode()//all edges and sphere are under this node
    lazy var nodeForHighlight:SCNNode = {
        let minV = self.graphToDraw!.minVertex
        let maxV = self.graphToDraw!.maxVertex
        let n = SCNNode()
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIColor.whiteColor()
        let sphereNode1 = SCNNode(geometry: sphere)
        sphereNode1.position = SCNVector3Make(minV.x, minV.y, minV.z)
        let sphereNode2 = SCNNode(geometry: sphere)
        sphereNode2.position = SCNVector3Make(maxV.x, maxV.y, maxV.z)
        n.addChildNode(sphereNode1)
        n.addChildNode(sphereNode2)
        return n
    }()
    
    
    @IBAction func highlightSwitchChange(sender: UISwitch) {
        if sender.on
        {
            nodeForOffset.addChildNode(nodeForHighlight)
        }else{
            nodeForHighlight.removeFromParentNode()
        }
    }
    
    @IBAction func edgeSwitchChange(sender: UISwitch) {
        if sender.on
        {
            nodeForOffset.addChildNode(nodeForLine)
        }
        if !sender.on
        {
            nodeForLine.removeFromParentNode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nodeForOffset.addChildNode(nodeForLine)
        draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func draw()
    {
        if graphToDraw == nil
        {
            return
        }
        glLineWidth(2)
        sceneView.backgroundColor = UIColor.blackColor()
        sceneView.allowsCameraControl = true
        let sceneInstance = SCNScene()
        
        let camera = SCNCamera()
        camera.xFov = 45
        camera.yFov = 45
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 3)
        sceneInstance.rootNode.addChildNode(cameraNode)
        
        var offset = SCNVector3Make(0, 0, 0)

        if let _ = graphToDraw as? Square
        {
            offset = SCNVector3Make(-0.5, -0.5, 0)
        }
        nodeForOffset.position = offset
        sceneInstance.rootNode.addChildNode(nodeForOffset)
        
        for v in graphToDraw!.vertices
        {
            let sphereNode = Draw.getSphereNode(v)
            nodeForOffset.addChildNode(sphereNode)
            for i in v.adjArray
            {
                let adjV = graphToDraw!.vertices[i]
                let lineNode = Draw.getLineNode(v, v2: adjV)
                nodeForLine.addChildNode(lineNode)
            }
        }
        
        sceneView.scene = sceneInstance
        sceneView.autoenablesDefaultLighting = true
    }

    
}