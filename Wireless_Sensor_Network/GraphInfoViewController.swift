//
//  GraphInfoViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import UIKit

class GraphInfoViewController: UIViewController {
    
    var info = String()
    @IBOutlet weak var infoLabel: UILabel!
    
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