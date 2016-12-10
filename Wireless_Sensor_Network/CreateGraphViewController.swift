//
//  CreateGraphViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import UIKit

class CreateGraphViewController: UIViewController {

    @IBOutlet weak var avgDegreeText: UITextField!
    @IBOutlet weak var nVerText: UITextField!
    @IBOutlet weak var shapeSegCtrl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //avgDegreeText.keyboardType = .DecimalPad
        //nVerText.keyboardType = .PhonePad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let tab = segue.destinationViewController as? TabBarViewController
        {
            var g:RGG?
            let avgD = Int(avgDegreeText.text!)!
            let nV = Int(nVerText.text!)!
            switch shapeSegCtrl.selectedSegmentIndex
            {
            case 0:
                g = Disk(avgDegree: avgD, numberOfVertices: nV)
            case 1:
                g = Square(avgDegree: avgD, numberOfVertices: nV)
            case 2:
                g = Sphere(avgDegree: avgD, numberOfVertices: nV)
            default:
                break
            }
            if let dest = (tab.viewControllers?[0] as? RGGViewController)
            {
                dest.graphToDraw = g
            }
            
            if let dest = (tab.viewControllers?[1] as? BackboneViewController)
            {
                var b1 = [Vertex]()
                var b2 = [Vertex]()
                if let twoBs = g?.twoBackbones
                {
                    for id in twoBs.b1IdArray
                    {
                        b1.append(g!.vertices[id])
                    }
                    for id in twoBs.b2IdArray
                    {
                        b2.append(g!.vertices[id])
                    }
                }
                dest.backbone0 = b1
                dest.backbone1 = b2
            }
            
            if let dest = (tab.viewControllers?[2] as? ChartsViewController)
            {
                
            }
            
            if let dest = (tab.viewControllers?[3] as? GraphInfoViewController)
            {
                dest.info = "Hello World"
            }
        }
    }
}
