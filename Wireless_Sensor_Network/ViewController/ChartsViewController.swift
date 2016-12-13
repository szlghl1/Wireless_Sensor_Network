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
    @IBOutlet weak var colorDistriView: BarChartView!
    @IBOutlet weak var compareDegreeView: LineChartView!
    
    //should be set in segue
    //index is degree, ele is count
    var degreeDistriArray: [Int]?
    //index is color, ele is count
    var colorDistriArray: [Int]?
    //index is id, ele is the degree of the vertex
    var degreeForVertex: (original: [Int]?, delete: [Int]?) = (nil, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDegreeDistriView()
        initColorDistriView()
        initCompareDegreeView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDegreeDistriView(){
        if degreeDistriArray == nil{
            return
        }
        let e = degreeDistriArray?.enumerated().map({x, y in return BarChartDataEntry(x:Double(x), y: Double(y))})
        let data = BarChartData()
        let ds = BarChartDataSet(values: e, label: "degree distribution")
        ds.colors = [UIColor(red:80/255,green:168/255,blue:227/255,alpha:1)]
        data.addDataSet(ds)
        self.degreeDistriView.data = data
        self.degreeDistriView.gridBackgroundColor = UIColor.white
        self.degreeDistriView.chartDescription?.text = "degree distribution"
    }
    func initColorDistriView(){
        if colorDistriArray == nil{
            return
        }
        let e = colorDistriArray?.enumerated().map({x, y in return BarChartDataEntry(x:Double(x), y: Double(y))})
        let data = BarChartData()
        let ds = BarChartDataSet(values: e, label: "color distribution")
        ds.colors = [UIColor(red:127/255,green:176/255,blue:5/255,alpha:1)]
        data.addDataSet(ds)
        self.colorDistriView.data = data
        self.colorDistriView.gridBackgroundColor = UIColor.white
        self.colorDistriView.chartDescription?.text = "color distribution"
    }
    func initCompareDegreeView(){
        if degreeForVertex.original == nil || degreeForVertex.delete == nil{
            return
        }
        let data = LineChartData()
        
        let e1 = degreeForVertex.original?.enumerated().map({x, y in return ChartDataEntry(x:Double(x), y: Double(y))})
        let ds1 = LineChartDataSet(values: e1, label: "orginal degree")
        ds1.colors = [UIColor(red:80/255,green:168/255,blue:227/255,alpha:1)]
        ds1.drawCirclesEnabled = false
        data.addDataSet(ds1)

        let e2 = degreeForVertex.delete?.enumerated().map({x, y in return ChartDataEntry(x:Double(x), y: Double(y))})
        let ds2 = LineChartDataSet(values: e2, label: "degree when deleted")
        ds2.colors = [UIColor(red:127/255,green:176/255,blue:5/255,alpha:1)]
        ds2.drawCirclesEnabled = false
        data.addDataSet(ds2)
        
        self.compareDegreeView.data = data
        self.compareDegreeView.gridBackgroundColor = UIColor.white
        self.compareDegreeView.chartDescription?.text = "smallest last ordering"
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
