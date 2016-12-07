//
//  RGG.swift
//  Wireless Sensor Network
//
//  Created by 凌何 on 16/12/6.
//  Copyright © 2016年 凌何. All rights reserved.
//

import Foundation

func square(a:Double) -> Double {return a * a}

public class RGG {
    public var vertices = [Vertex]()
    let radius:Double
    let nVertices:Int//number of vertices
    lazy var nEdges:Int =
    {
        var n:Int = 0
        for v in self.vertices
        {
            n += v.adjArray.count
        }
        n /= 2
        return n
    }()
    lazy var avgDegree:Double = {
        return Double(self.nEdges*2) / Double(self.nVertices)
    }()
    
    init(r:Double, numberOfVertices:Int)
    {
        if(r < 0 || numberOfVertices < 1)
        {
            preconditionFailure("incorrect parameters")
        }
        radius = r
        nVertices = numberOfVertices
    }
    
    func createVertices() throws
    {
        preconditionFailure("createVertices should be implemented in subclass of RGG")
    }
    
    //create edges by the sweep algorithm
    func createEdges()
    {
        if(vertices.count < 1)
        {
            preconditionFailure("There should be at least one vertex.")
        }
        var copyVertices = vertices.sort({$0.x < $1.x})
        let window = radius
        for i in 1...(copyVertices.count-1)
        {
            let curX = copyVertices[i].x
            var j = i - 1
            while(j >= 0 && abs(copyVertices[j].x - curX) <=  window)
            {
                if(ifAdajacent(copyVertices[i], v2: copyVertices[j]))
                {
                    copyVertices[i].adjArray.append(copyVertices[j].id)
                    copyVertices[j].adjArray.append(copyVertices[i].id)
                    copyVertices[i].degree++
                    copyVertices[j].degree++
                }
                j--
            }
            j = i + 1
//            Brute-force
//            for j in 0...(i-1)
//            {
//                if(ifAdajacent(copyVertices[i], v2: copyVertices[j]))
//                {
//                    copyVertices[i].adjArray.append(copyVertices[j].id)
//                    copyVertices[j].adjArray.append(copyVertices[i].id)
//                }
//            }
        }
    }
    
    /********************************
    Pass two vertices as parameters, determine
    if their distance is equal or less than radius
     ********************************/
    func ifAdajacent(v1:Vertex, v2:Vertex) -> Bool
    {
        let disSq = square(v1.x - v2.x) + square(v1.y - v2.y) + square(v1.z - v2.z)
        return disSq <= square(radius)
    }
}