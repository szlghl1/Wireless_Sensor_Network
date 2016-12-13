//
//  BackboneViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016 LingHe. All rights reserved.
//

import UIKit
import SceneKit
class BackboneViewController: UIViewController {
    //should be set in segue
    var backbone0: [Vertex]?
    var backbone1: [Vertex]?
    var shape: GraphShapeEnum?
    var b0Info:String?
    var b1Info:String?
    
    var rForDrawSphere:Float = 0.02
    
    let b0Node = SCNNode()
    let b1Node = SCNNode()
    
    let nodeForLine = SCNNode()//all lines are under this node
    let nodeForOffset = SCNNode()//all edges and sphere are under this node
    
    @IBAction func switchBackbone(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0{
            b1Node.removeFromParentNode()
            nodeForOffset.addChildNode(b0Node)
            infoLabel.text = b0Info
        }else{
            b0Node.removeFromParentNode()
            nodeForOffset.addChildNode(b1Node)
            infoLabel.text = b1Info
        }
    }
    @IBOutlet weak var backboneView: SCNView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        infoLabel.text = b0Info
        
        if shape == .square{
            //area of square is half smaller
            nodeForOffset.scale = SCNVector3Make(2, 2, 2)
            //1 = 2 * 0.5
            nodeForOffset.position = SCNVector3Make(-1, -1, 0)
            rForDrawSphere /= 2
        }
        initSCNNodeForBackbone()
        nodeForOffset.addChildNode(b0Node)

        glLineWidth(2)
        backboneView.backgroundColor = UIColor.black
        backboneView.allowsCameraControl = true
        let sceneInstance = SCNScene()
        
        let camera = SCNCamera()
        camera.xFov = 45
        camera.yFov = 45
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 3)
        sceneInstance.rootNode.addChildNode(cameraNode)
        
        sceneInstance.rootNode.addChildNode(nodeForOffset)
        
        backboneView.scene = sceneInstance
        backboneView.autoenablesDefaultLighting = true
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSCNNodeForBackbone(){
        var dIDToV = [Int:Vertex]()
        if let b = backbone0
        {
            var edgeCoorArray = [(fromV: Vertex, toV: Vertex)]()
            for v in b {
                dIDToV[v.id] = v
                let n = Draw.getSphereNode(v, r: rForDrawSphere)
                b0Node.addChildNode(n)
            }
            for v in b{
                for adjID in v.adjArray{
                    edgeCoorArray.append((v, dIDToV[adjID]!))
                }
            }
            let ln = Draw.getLinesNode(pathTupleArr: edgeCoorArray)
            b0Node.addChildNode(ln)
        }
        
        if let b = backbone1
        {
            var edgeCoorArray = [(fromV: Vertex, toV: Vertex)]()
            for v in b {
                dIDToV[v.id] = v
                let n = Draw.getSphereNode(v, r: rForDrawSphere)
                b1Node.addChildNode(n)
            }
            for v in b{
                for adjID in v.adjArray{
                    edgeCoorArray.append((v, dIDToV[adjID]!))
                }
            }
            let ln = Draw.getLinesNode(pathTupleArr: edgeCoorArray)
            b1Node.addChildNode(ln)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
