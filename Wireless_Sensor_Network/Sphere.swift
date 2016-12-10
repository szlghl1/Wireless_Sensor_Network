//
//  Sphere.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/7.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

open class Sphere: RGG
{
    //create vertices in unit sphere (x, y, z in [-1,1])
    override func createVertices(_ nV:Int)
    {
        for i in 0...(nV-1)
        {
            var len:Float
            var x:Float
            var y:Float
            var z:Float
            repeat
            {
                x = Float.random(-1, max: 1)
                y = Float.random(-1, max: 1)
                z = Float.random(-1, max: 1)
                len = sqrt(square(x) + square(y) + square(z))
            }while(len > 1)
            x /= len; y /= len; z /= len
            let v = Vertex(id: i, x: x, y: y, z: z)
            vertices.append(v)
        }
    }
}
