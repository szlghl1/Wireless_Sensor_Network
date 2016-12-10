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
    var backbone0: [Vertex]?
    var backbone1: [Vertex]?
    
    let nodeForLine = SCNNode()//all lines are under this node
    let nodeForOffset = SCNNode()//all edges and sphere are under this node
    
    @IBAction func switchBackbone(sender: UISegmentedControl)
    {
        
    }
    @IBOutlet weak var backboneView: SCNView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
