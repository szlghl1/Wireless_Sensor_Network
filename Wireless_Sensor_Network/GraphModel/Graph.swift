//
//  Graph.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import Foundation

open class Graph {
    //the index is id
    open var vertices = [Vertex]()
    lazy var nVertices:Int = {self.vertices.count}()
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
    lazy var avgDegree:Float = {
        return Float(self.nEdges*2) / Float(self.nVertices)
    }()
    lazy var numColor:Int = {
        var maxColor = 0
        for v in self.vertices
        {
            if v.color > maxColor
            {
                maxColor = v.color
            }
        }
        return maxColor + 1
    }()
    lazy var minDegree:Int = {
        var res = 0
        if self.vertices.count != 0
        {
            res = self.vertices[0].degree
            for v in self.vertices
            {
                res = (res < v.degree) ? res : v.degree
            }
        }
        return res
    }()
    //vertex with min degree
    lazy var minVertex:Vertex = {
        var res = Vertex(id: -1, x: -1, y: -1)
        for v in self.vertices
        {
            if v.degree == self.minDegree
            {
                res = v
            }
        }
        return res
    }()
    lazy var maxDegree:Int = {
        var res = 0
        if self.vertices.count != 0
        {
            res = self.vertices[0].degree
            for v in self.vertices
            {
                res = (res > v.degree) ? res : v.degree
            }
        }
        return res
    }()
    lazy var maxVertex:Vertex = {
        var res = Vertex(id: -1, x: -1, y: -1)
        for v in self.vertices
        {
            if v.degree == self.maxDegree
            {
                res = v
            }
        }
        return res
    }()
    lazy var colorDistribution:[Int] = {
        var res = [Int](repeating: 0, count: self.numColor)
        for v in self.vertices{
            res[v.color] += 1
        }
        return res
    }()
    lazy var degreeDistribution:[Int] = {
        var res = [Int](repeating: 0, count: self.maxDegree + 1)
        for v in self.vertices{
            res[v.degree] += 1
        }
        return res
    }()
}
