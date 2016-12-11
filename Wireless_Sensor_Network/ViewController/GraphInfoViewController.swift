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
    var numVertices = 0
    var radius = 0
    var numEdges = 0
    var minDegree = 0
    var avgDegree = 0
    var maxDegree = 0
    var maxDeleteDegree = 0
    var numColor = 0
    var maxColorSize = 0
    var terminalCliqueSize = 0
    var numEdgesLargestBipartite = 0
    var numFaces:Int? = nil // only applicable to sphere
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        infoLabel.text = info
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
