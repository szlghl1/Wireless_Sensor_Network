//
//  GraphInfoViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import UIKit

class GraphInfoViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    
    var info = String()
    var numVertices: Int = -1
    var radius: Float = -1
    var numEdges: Int = -1
    var minDegree: Int = -1
    var avgDegree:Float = -1
    var maxDegree: Int = -1
    var maxDeleteDegree: Int = -1
    var numColor: Int = -1
    var maxColorSize: Int = -1
    var terminalCliqueSize: Int = -1
    var numEdgesLargestBipartite: Int = -1
    var numFaces:Int = -1 // only applicable to sphere
    var shape:GraphShapeEnum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initInfo()
        infoLabel.numberOfLines = 0
        infoLabel.text = info
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInfo(){
        info += "Number of vertices = " + String(describing: numVertices) + "\n"
        info += "Radius = " + String(describing: radius) + "\n"
        info += "Number of edges = " + String(describing: numEdges) + "\n"
        info += "Minimum degree = " + String(describing: minDegree) + "\n"
        info += "Average degree = " + String(describing: avgDegree) + "\n"
        info += "Maximum degree = " + String(describing: maxDegree) + "\n"
        info += "Maximum degree when deleted = " + String(describing: maxDeleteDegree) + "\n"
        info += "Number of color = " + String(describing: numColor) + "\n"
        info += "Size of maximum color set = " + String(describing: maxColorSize) + "\n"
        info += "Terminal clique size = " + String(describing: terminalCliqueSize) + "\n"
        info += "# of edges in the largest bipartite = " + String(describing: numEdgesLargestBipartite) + "\n"
        //only sphere has this property
        if shape == .sphere{
            info += "# of faces in the largest backbone = " + String(describing: numFaces) + "\n"
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
