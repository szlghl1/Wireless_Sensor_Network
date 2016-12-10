//
//  RandomColor.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import Foundation
import SceneKit

class RandomColor {
    static var colorMap = [Int: (CGFloat,CGFloat,CGFloat)]()
    
    class func getColor(id: Int) -> UIColor
    {
        if colorMap[id] == nil
        {
            let r = CGFloat(drand48())
            let g = CGFloat(drand48())
            let b = CGFloat(drand48())
            colorMap[id] = (r, g, b)
        }
        let t = colorMap[id]!
        return UIColor(red: t.0, green: t.1, blue: t.2, alpha: 1)
    }
}