//
//  Disk.swift
//  Wireless Sensor Network
//
//  Created by LingHe on 16/12/7.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

open class Disk: RGG
{
    //create vertices in unit disk(r = 1)
    override func createVertices(_ nV: Int)
    {
        for i in 0...(nV-1)
        {
            var x:Float
            var y:Float
            repeat
            {
                x = Float.random(-1, max: 1)
                y = Float.random(-1, max: 1)
            }while(square(x) + square(y) > 1)
            let v = Vertex(id: i, x: x, y: y)
            vertices.append(v)
        }
    }    
}
