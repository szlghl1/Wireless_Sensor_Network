//
//  RGG.swift
//  Wireless Sensor Network
//
//  Created by LingHe on 16/12/6.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

func square(a:Float) -> Float {return a * a}

public class RGG: Graph {
    let radius:Float
    public init(avgDegree: Int, numberOfVertices: Int)
    {
        let r = sqrt(Float(avgDegree) / Float(numberOfVertices))
        if(r < 0 || numberOfVertices < 1)
        {
            preconditionFailure("incorrect parameters")
        }
        radius = r
        super.init()
        createVertices(numberOfVertices)
        createEdges()
        color()
    }
    func createVertices(nV: Int)
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
                    //it works both for element in copyVertices is copy and reference of ele in vertices
                    let id_i = copyVertices[i].id
                    let id_j = copyVertices[j].id
                    vertices[id_i].adjArray.append(id_j)
                    vertices[id_j].adjArray.append(id_i)
                    vertices[id_i].degree++
                    vertices[id_j].degree++
                }
                j--
            }
            j = i + 1
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
    
    //the return stack contains dulipcate of vertices after smallest-last-order
    func getSmallestLastOrder() -> Stack<Vertex>
    {
        var s = Stack<Vertex>()
        var verticesIndex = [Vertex]()
        var maxDegree = 0
        //initialize maxDegree and verticesIndex
        for v in vertices
        {
            verticesIndex.append(v.copy())
            if(v.degree > maxDegree)
            {
                maxDegree = v.degree
            }
        }
        
        var degreeArray = Array(count: maxDegree + 1, repeatedValue: [Vertex]())
        for v in verticesIndex
        {
            degreeArray[v.degree].append(v)
        }
        
        let firstNonEmptyDegree = {
            () -> Int in
            for i in 0...(degreeArray.count - 1)
            {
                if(degreeArray[i].count > 0)
                {
                    return i
                }
            }
            return -1
        }
        let removeVertex = {
            (v: Vertex) in
            for i in v.adjArray
            {
                let curAdjV = verticesIndex[i]
                degreeArray[curAdjV.degree] = degreeArray[curAdjV.degree].filter({$0.id != curAdjV.id})
                curAdjV.deleteAdjByID(v.id)
                degreeArray[curAdjV.degree].append(curAdjV)
            }
            return
        }
        for _ in 0...(vertices.count - 1)
        {
            let i = firstNonEmptyDegree()
            let v = degreeArray[i][0]
            removeVertex(v)
            s.push(v)
            degreeArray[i].removeAtIndex(0)
        }
        return s
    }
    
    /*********************************************
    //color the vertices in the order given by a stack
    //color the vertices from the top to bottom of the stack
    *********************************************/
    func color()
    {
        var s = getSmallestLastOrder()
        let firstAvalibleColor =
        {
            (v: Vertex) -> Int in
            if v.adjArray.count == 0
            {
                return 0
            }
            var usedColor = [Int]()
            for adjID in v.adjArray
            {
                usedColor.append(self.vertices[adjID].color)
            }
            usedColor.sortInPlace()
            for i in 0...usedColor.count - 1
            {
                if usedColor[i] != i
                {
                    return i
                }
            }
            return usedColor.last!
        }
        for _ in 0...s.items.count - 1
        {
            let v = s.pop()
            vertices[v.id].color = firstAvalibleColor(v)
        }
    }
}