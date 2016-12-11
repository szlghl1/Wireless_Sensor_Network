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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (avgDegreeText.text?.isEmpty)!{
            let v = UIAlertController(title: "Empty parameter", message: "You should fill the parameters.", preferredStyle: .alert)
            let act = UIAlertAction(title: "return", style: .cancel, handler: nil)
            v.addAction(act)
            self.present(v, animated: true, completion: nil)
            return false
        }
        if Int(avgDegreeText.text!) == nil || Int(nVerText.text!) == nil
        {
            let v = UIAlertController(title: "Invalid parameter", message: "Please modify your parameters.", preferredStyle: .alert)
            let act = UIAlertAction(title: "return", style: .cancel, handler: nil)
            v.addAction(act)
            self.present(v, animated: true, completion: nil)
            return false
        }

        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let tab = segue.destination as? TabBarViewController
        {
            var g:RGG?
            
            //validation is done in shouldSegue
            let avgD = Int(avgDegreeText.text!)!
            let nV = Int(nVerText.text!)!
            
            var shape: GraphShapeEnum?
            switch shapeSegCtrl.selectedSegmentIndex
            {
            case 0:
                g = Disk(avgDegree: avgD, numberOfVertices: nV)
                shape = .disk
            case 1:
                g = Square(avgDegree: avgD, numberOfVertices: nV)
                shape = .square
            case 2:
                g = Sphere(avgDegree: avgD, numberOfVertices: nV)
                shape = .sphere
            default:
                break
            }
            if let dest = (tab.viewControllers?[0] as? RGGViewController)
            {
                dest.graphToDraw = g
            }
            
            if let dest = (tab.viewControllers?[1] as? BackboneViewController)
            {
                if let twoBs = g?.twoBackbones
                {
                    dest.backbone0 = twoBs.b0VertexArray
                    dest.backbone1 = twoBs.b1VertexArray
                    dest.shape = shape
                }
            }
            
            if let dest = (tab.viewControllers?[2] as? ChartsViewController)
            {
                dest.degreeDistriArray = g?.degreeDistribution
                dest.colorDistriArray = g?.colorDistribution
                dest.degreeForVertex.original = g?.degreeForVertexArray
                dest.degreeForVertex.delete = g?.degreeWhenDeleteArray
            }
            
            if let dest = (tab.viewControllers?[3] as? GraphInfoViewController)
            {
                dest.info = "Hello World"
            }
        }
    }
}
