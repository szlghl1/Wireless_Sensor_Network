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
        let r = sqrt(Double(4) * Double(avgDegree) / Double(numberOfVertices))
        super.init(r: r, numberOfVertices: numberOfVertices)
        createVertices()
        createEdges()
    }
    
    //create vertices in unit sphere (x, y, z in [-1,1])
    override func createVertices()
    {
        for i in 0...(nVertices-1)
        {
            var len:Double
            var x:Double
            var y:Double
            var z:Double
            repeat
            {
                x = Double.random(-1, max: 1)
                y = Double.random(-1, max: 1)
                z = Double.random(-1, max: 1)
                len = sqrt(square(x) + square(y) + square(z))
            }while(len > 1)
            x /= len; y /= len; z /= len
            let v = Vertex(id: i, x: x, y: y, z: z)
            vertices.append(v)
        }
    }
}