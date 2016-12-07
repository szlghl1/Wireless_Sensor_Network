//
//  Sphere.swift
//  Wireless_Sensor_Network
//
//  Created by 凌何 on 16/12/7.
//  Copyright © 2016年 凌何. All rights reserved.
//

import Foundation

public class Sphere: RGG
{
    public init(avgDegree: Int, numberOfVertices: Int)
    {
        let r = sqrt(4.0 * Double(avgDegree) / Double(numberOfVertices))
        super.init(r: r, numberOfVertices: numberOfVertices)
        createVertices()
        createEdges()
    }
    
    //create vertices in unit sphere (x, y, z in [-1,1])
    override func createVertices()
    {
        for i in 0...(nVertices-1)
        {
            var x = Double.random(-1, max: 1)
            var y = Double.random(-1, max: 1)
            var z = Double.random(-1, max: 1)
            let len = sqrt(square(x) + square(y) + square(z))
            x /= len; y /= len; z /= len;
            let v = Vertex(id: i, x: x, y: y)
            vertices.append(v)
        }
    }
}