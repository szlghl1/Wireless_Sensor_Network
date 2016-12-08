//
//  ViewController.swift
//  Wireless_Sensor_Network
//
//  Created by 凌何 on 16/12/7.
//  Copyright © 2016年 凌何. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    var colorMap = [Int: (CGFloat,CGFloat,CGFloat)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glLineWidth(2)
        sceneView.backgroundColor = .darkGrayColor()
        sceneView.allowsCameraControl = true
        let sceneInstance = SCNScene()
        
        let camera = SCNCamera()
        camera.xFov = 10
        camera.yFov = 45
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 3)
        sceneInstance.rootNode.addChildNode(cameraNode)

        let squareRGG = Disk(avgDegree: 20, numberOfVertices: 300)
        
        for v in squareRGG.vertices
        {
            let sphere = SCNSphere(radius: 0.05)
            sphere.firstMaterial?.diffuse.contents = getColor(v.color)
            let sphereNode = SCNNode(geometry: sphere)
            sphereNode.position = SCNVector3Make(Float(v.x), Float(v.y), Float(v.z))
            sceneInstance.rootNode.addChildNode(sphereNode)
            for i in v.adjArray
            {
                let adjV = squareRGG.vertices[i]
                let lineNode = getLineNode(v, v2: adjV)
                sceneInstance.rootNode.addChildNode(lineNode)
            }

        }
        sceneView.scene = sceneInstance
        sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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