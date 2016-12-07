//
//  Vertex.swift
//  Wireless Sensor Network
//
//  Created by 凌何 on 16/12/6.
//  Copyright © 2016年 凌何. All rights reserved.
//

import Foundation
public class Vertex {
    public let x:Double, y:Double, z:Double
    public let id:Int
    public var color:Int = 0
    public var adjArray = [Int]()
    public var degree = 0
    
    init(id:Int, x:Double, y:Double, z:Double = 0)
    {
        self.id = id
        self.x = x
        self.y = y
        self.z = z
    }
}