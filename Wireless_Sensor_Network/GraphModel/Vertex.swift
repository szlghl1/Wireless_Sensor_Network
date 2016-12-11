//
//  Vertex.swift
//  Wireless Sensor Network
//
//  Created by LingHe on 16/12/6.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation
open class Vertex {
    open let x:Float, y:Float, z:Float
    open let id:Int
    open var color:Int?
    open var adjArray = [Int]()
    //degree is read-only derived attribute, no need to update
    open var degree:Int {return adjArray.count}
    
    init(id:Int, x:Float, y:Float, z:Float = 0)
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
        self.adjArray = v.adjArray    }
    
    func copy() -> Vertex
    {
        return Vertex(self)
    }
    
    func deleteAdjByID(_ id:Int)
    {
        self.adjArray = self.adjArray.filter({$0 != id})
    }
}
