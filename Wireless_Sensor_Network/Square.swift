//
//  Square.swift
//  Wireless_Sensor_Network
//
//  Created by 凌何 on 16/12/7.
//  Copyright © 2016年 凌何. All rights reserved.
//

import Foundation

public class Square: RGG
{
    public init(avgDegree: Int, numberOfVertices: Int)
    {
        let r = sqrt(Double(avgDegree) / (M_PI * Double(numberOfVertices)))
        super.init(r: r, numberOfVertices: numberOfVertices)
        createVertices()
        createEdges()
    }
    
    //create vertices in unit square (x in [0,1], y in [0,1])
    override func createVertices()
    {
        for i in 0...(nVertices-1)
        {
            let x = Double.random(0, max: 1)
            let y = Double.random(0, max: 1)
            let v = Vertex(id: i, x: x, y: y)
            vertices.append(v)
        }
    }
}