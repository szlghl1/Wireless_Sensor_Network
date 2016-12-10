//
//  Square.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/7.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

open class Square: RGG
{    
    //create vertices in unit square (x in [0,1], y in [0,1])
    override func createVertices(_ nV: Int)
    {
        for i in 0...(nV-1)
        {
            let x = Float.random(0, max: 1)
            let y = Float.random(0, max: 1)
            let v = Vertex(id: i, x: x, y: y)
            vertices.append(v)
        }
    }
}
