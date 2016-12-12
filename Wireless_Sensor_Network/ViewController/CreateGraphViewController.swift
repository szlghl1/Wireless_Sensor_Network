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
            
            print("preparing RGGView")
            let t = NSDate()
            if let dest = (tab.viewControllers?[0] as? RGGViewController)
            {
                dest.graphToDraw = g
            }
            
            print("preparing BackboneView")
            print("\(-t.timeIntervalSinceNow) seconds passed")
            let countEdgeInBackbone:([Vertex]?) -> Int = {
                vArr in
                if vArr == nil{
                    return -1
                }
                var res = 0
                for v in vArr!{
                    res += v.degree
                }
                return res / 2
            }
            let dominationOfBackbone:([Vertex]?) -> Float = {
                vArr in
                if vArr == nil{
                    return -1
                }
                var res:Float = 0
                var s = Set<Int>()
                for v in vArr!{
                    for adjID in v.adjArray{
                        s.insert(adjID)
                    }
                }
                if let c = g?.vertices.count{
                    res = Float(s.count) / Float(c)
                }
                return res
            }
            let nEdgeInBackbone0:Int = countEdgeInBackbone(g?.twoBackbones.b0VertexArray)
            
            let nEdgeInBackbone1:Int = countEdgeInBackbone(g?.twoBackbones.b1VertexArray)
            
            let dominationRateB0 = dominationOfBackbone(g?.twoBackbones.b0VertexArray)
            let dominationRateB1 = dominationOfBackbone(g?.twoBackbones.b1VertexArray)
                
            if let dest = (tab.viewControllers?[1] as? BackboneViewController)
            {
                if let twoBs = g?.twoBackbones
                {
                    dest.backbone0 = twoBs.b0VertexArray
                    dest.backbone1 = twoBs.b1VertexArray
                    dest.shape = shape
                    dest.b0Info = String("# of vertices = \(twoBs.b0VertexArray.count)\n# of edges = \(nEdgeInBackbone0)\ndomination rate = \(dominationRateB0)")
                    dest.b1Info = String("# of vertices = \(twoBs.b1VertexArray.count)\n# of edges = \(nEdgeInBackbone1)\ndomination rate = \(dominationRateB1)")
                }
            }
            
            print("preparing ChartsView")
            print("\(-t.timeIntervalSinceNow) seconds passed")
            if let dest = (tab.viewControllers?[2] as? ChartsViewController)
            {
                dest.degreeDistriArray = g?.degreeDistribution
                dest.colorDistriArray = g?.colorDistribution
                dest.degreeForVertex.original = g?.degreeForVertexArray
                dest.degreeForVertex.delete = g?.degreeWhenDeleteArray
            }
            
            print("preparing InfoView")
            print("\(-t.timeIntervalSinceNow) seconds passed")
            if let dest = (tab.viewControllers?[3] as? GraphInfoViewController)
            {
                dest.shape = shape
                dest.numVertices = g?.nVertices ?? -1
                dest.radius = g?.radius ?? -1
                dest.numEdges = g?.nEdges ?? -1
                dest.minDegree = g?.minDegree ?? -1
                dest.avgDegree = g?.avgDegree ?? -1
                dest.maxDegree = g?.maxDegree ?? -1
                dest.maxDeleteDegree = g?.maxDeleteDegree ?? -1
                dest.numColor = g?.numColor ?? -1
                dest.maxColorSize = g?.maxColorSize ?? -1
                dest.terminalCliqueSize = {
                    var res = 0
                    if let dgrDltArr = g?.degreeWhenDeleteArray{
                        for i in 0..<dgrDltArr.count{
                            let j = dgrDltArr.count - i - 1
                            if dgrDltArr[j] == i{
                                res += 1
                            }
                        }
                    }
                    return res
                }()
                dest.numEdgesLargestBipartite = nEdgeInBackbone0
                if let sg = g as? Sphere{
                    let b = sg.twoBackbones.b0VertexArray
                    dest.numFaces = nEdgeInBackbone0 - b.count + 1//only for sphere
                }
            }
        }
    }
}
