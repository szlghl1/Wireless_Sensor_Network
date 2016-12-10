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
    var colorMap = [Int: (CGFloat,CGFloat,CGFloat)]()
    
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
            let sphere = SCNSphere(radius: 0.03)
            sphere.firstMaterial?.diffuse.contents = getColor(v.color)
            let sphereNode = SCNNode(geometry: sphere)
            sphereNode.position = SCNVector3Make(v.x, v.y, v.z)
            nodeForOffset.addChildNode(sphereNode)
            for i in v.adjArray
            {
                let adjV = graphToDraw!.vertices[i]
                let lineNode = getLineNode(v, v2: adjV)
                nodeForLine.addChildNode(lineNode)
            }
        }
        
        sceneView.scene = sceneInstance
        sceneView.autoenablesDefaultLighting = true
    }
    
    func getColor(c: Int) -> UIColor
    {
        if colorMap[c] == nil
        {
            let r = CGFloat(drand48())
            let g = CGFloat(drand48())
            let b = CGFloat(drand48())
            colorMap[c] = (r, g, b)
        }
        let t = colorMap[c]!
        return UIColor(red: t.0, green: t.1, blue: t.2, alpha: 1)
    }
    
    func getLineNode(v1: Vertex, v2: Vertex) -> SCNNode
    {
        let positions: [Float32] = [Float32(v1.x), Float32(v1.y), Float32(v1.z), Float32(v2.x), Float32(v2.y), Float32(v2.z)]
        let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
        let indices: [Int32] = [0, 1]
        let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
        
        let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
        let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
        
        let line = SCNGeometry(sources: [source], elements: [element])
        return SCNNode(geometry: line)
    }
}