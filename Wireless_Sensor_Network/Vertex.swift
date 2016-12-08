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
    
    init(_ v:Vertex)
    {
        self.x = v.x; self.y = v.y; self.z = v.z;
        self.id = v.id
        self.color = v.color
        self.adjArray = v.adjArray
        self.degree = v.degree
    }
    
    func copy() -> Vertex
    {
        return Vertex(self)
    }
    
    func deleteAdjByID(id:Int)
    {
        self.adjArray = self.adjArray.filter({$0 != id})
        self.degree--
    }
}