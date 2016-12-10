//
//  ChartsViewController.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var degreeDistriView: BarChartView!
    @IBOutlet weak var compareDegreeView: LineChartView!
    @IBOutlet weak var colorDistriView: BarChartView!
    
    var degreeDistriArray: [Int]?//should be set in segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let e = degreeDistriArray?.enumerated().map({x, y in return BarChartDataEntry(x:Double(x), y: Double(y))})
        let data = BarChartData()
        let ds = BarChartDataSet(values: e, label: "degree distribution")
        ds.colors = [UIColor.red]
        data.addDataSet(ds)
        self.degreeDistriView.data = data
        self.degreeDistriView.gridBackgroundColor = UIColor.white
        self.degreeDistriView.chartDescription?.text = "degree distribution"
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
