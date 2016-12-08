//
//  Disk.swift
//  Wireless Sensor Network
//
//  Created by 凌何 on 16/12/7.
//  Copyright © 2016年 凌何. All rights reserved.
//

import Foundation

public class Disk: RGG
{
    public init(avgDegree: Int, numberOfVertices: Int)
    {
        let r = sqrt(Double(avgDegree) / Double(numberOfVertices))
        super.init(r: r, numberOfVertices: numberOfVertices)        
        createVertices()
        createEdges()
        color()
    }
    
    //create vertices in unit disk(r = 1)
    override func createVertices()
    {
        for i in 0...(nVertices-1)
        {
            var x:Double
            var y:Double
            repeat
            {
                x = Double.random(-1, max: 1)
                y = Double.random(-1, max: 1)
            }while(square(x) + square(y) > 1)
            let v = Vertex(id: i, x: x, y: y)
            vertices.append(v)
        }
    }    
}