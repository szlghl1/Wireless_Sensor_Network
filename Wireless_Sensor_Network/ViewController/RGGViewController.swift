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
    @IBOutlet weak var showEdgeSwitch: UISwitch!
    @IBOutlet weak var highlightSwitch: UISwitch!
    @IBOutlet weak var sceneView: SCNView!
    
    var graphToDraw:RGG?
    var rForDrawSphere:Float = 0.02
    var nodeForLine:SCNNode?//all lines are under this node
    let nodeForOffset = SCNNode()//all edges and sphere are under this node
    lazy var nodeForHighlight:SCNNode = {
        let minV = self.graphToDraw!.minVertex
        let maxV = self.graphToDraw!.maxVertex
        let n = SCNNode()
        let sphere = SCNSphere(radius: CGFloat(3 * self.rForDrawSphere))
        sphere.firstMaterial?.diffuse.contents = UIColor.white
        let sphereNode1 = SCNNode(geometry: sphere)
        sphereNode1.position = SCNVector3Make(minV.x, minV.y, minV.z)
        let sphereNode2 = SCNNode(geometry: sphere)
        sphereNode2.position = SCNVector3Make(maxV.x, maxV.y, maxV.z)
        n.addChildNode(sphereNode1)
        n.addChildNode(sphereNode2)
        return n
    }()
    
    
    @IBAction func highlightSwitchChange(_ sender: UISwitch) {
        if sender.isOn{
            nodeForOffset.addChildNode(nodeForHighlight)
        }else{
            nodeForHighlight.removeFromParentNode()
        }
    }
    
    @IBAction func edgeSwitchChange(_ sender: UISwitch) {
        if sender.isOn{
            if nodeForLine == nil{
                initLineNode()
            }
            nodeForOffset.addChildNode(nodeForLine!)
        }
        if !sender.isOn{
            nodeForLine?.removeFromParentNode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //the edgeSwitch shoule be off at the beginning
        doFirst()
        initVertexNode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initVertexNode(){
        if graphToDraw == nil
        {
            return
        }
        for v in graphToDraw!.vertices
        {
            let sphereNode = Draw.getSphereNode(v, r: rForDrawSphere)
            nodeForOffset.addChildNode(sphereNode)
        }
    }
    func initLineNode(){
        nodeForLine = SCNNode()
        if graphToDraw == nil
        {
            return
        }
        var linePathArray = [(Vertex, Vertex)]()
        for v in graphToDraw!.vertices
        {
            for i in v.adjArray
            {
                let adjV = graphToDraw!.vertices[i]
                linePathArray.append((v, adjV))
            }
        }
        let n = Draw.getLinesNode(pathTupleArr: linePathArray)
        nodeForLine!.addChildNode(n)
    }
    func doFirst()
    {
        if graphToDraw == nil
        {
            return
        }
        glLineWidth(2)
        sceneView.backgroundColor = UIColor.black
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
            //area of square is half smaller
            nodeForOffset.scale = SCNVector3Make(2, 2, 2)
            //2 * 0.5 = 1
            offset = SCNVector3Make(-1, -1, 0)
            rForDrawSphere /= 2
        }
        nodeForOffset.position = offset
        sceneInstance.rootNode.addChildNode(nodeForOffset)
                
        sceneView.scene = sceneInstance
        sceneView.autoenablesDefaultLighting = true
    }
}
