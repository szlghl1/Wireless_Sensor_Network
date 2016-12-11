//
//  RGG.swift
//  Wireless Sensor Network
//
//  Created by LingHe on 16/12/6.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

func square(_ a:Float) -> Float {return a * a}

open class RGG: Graph {
    //distance therehold for edge gernerating
    let radius:Float
    
    //should be set in smallest last ordering
    //the index is id
    var degreeForVertexArray:[Int]?
    var degreeWhenDeleteArray:[Int]?
    
    //the id of vertices in backbone are the same as orginal, but their index are different due to some vertices removed. Therefore the id in adjArray does not match the index
    lazy var twoBackbones: (b0VertexArray: [Vertex], b1VertexArray: [Vertex]) =
    {
        if(self.numColor < 4)
        {
            //the definition of "the first two backbones is to pick the largest two from possible combination of 4 color set
            return ([Vertex](),[Vertex]())
        }
        var colorArray = [(color:Int, idArray: [Int])]()
        for i in 0...self.numColor-1
        {
            colorArray.append((i, [Int]()))
        }
        for v in self.vertices
        {
            colorArray[v.color].idArray.append(v.id)
        }
        colorArray.sort(by: {$0.idArray.count > $1.idArray.count})
        let b0IDs = colorArray[0].idArray + colorArray[1].idArray
        let b1IDs = colorArray[0].idArray + colorArray[2].idArray
        var b0 = [Vertex]()
        var b1 = [Vertex]()
        for i in b0IDs{
            let v = self.vertices[i].copy()
            v.adjArray = v.adjArray.filter({b0IDs.contains($0)})
            b0.append(v)
        }
        for i in b1IDs{
            let v = self.vertices[i].copy()
            v.adjArray = v.adjArray.filter({b1IDs.contains($0)})
            b1.append(v)
        }
        return (b0, b1)
    }()
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
    func createVertices(_ nV: Int)
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
        var copyVertices = vertices.sorted(by: {$0.x < $1.x})
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
                    vertices[id_i].degree += 1
                    vertices[id_j].degree += 1
                }
                j -= 1
            }
            j = i + 1
        }
    }
    
    /********************************
    Pass two vertices as parameters, determine
    if their distance is equal or less than radius
     ********************************/
    func ifAdajacent(_ v1:Vertex, v2:Vertex) -> Bool
    {
        let disSq = square(v1.x - v2.x) + square(v1.y - v2.y) + square(v1.z - v2.z)
        return disSq <= square(radius)
    }
    
    //the return stack contains dulipcate of vertices after smallest-last-order
    func getSmallestLastOrder() -> Stack<Vertex>
    {
        //set in last stage, pushing vertex into stack
        degreeForVertexArray = Array(repeating: 0, count: nVertices)
        degreeWhenDeleteArray = Array(repeating: 0, count: nVertices)

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
        
        var degreeGroupWithArrayOfVertex = Array(repeating: [Vertex](), count: maxDegree + 1)
        for v in verticesIndex
        {
            degreeGroupWithArrayOfVertex[v.degree].append(v)
        }
        
        let firstNonEmptyDegree = {
            () -> Int in
            for i in 0...(degreeGroupWithArrayOfVertex.count - 1)
            {
                if(degreeGroupWithArrayOfVertex[i].count > 0)
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
                degreeGroupWithArrayOfVertex[curAdjV.degree] = degreeGroupWithArrayOfVertex[curAdjV.degree].filter({$0.id != curAdjV.id})
                curAdjV.deleteAdjByID(v.id)
                degreeGroupWithArrayOfVertex[curAdjV.degree].append(curAdjV)
            }
            return
        }
        for _ in 0...(vertices.count - 1)
        {
            let i = firstNonEmptyDegree()
            let v = degreeGroupWithArrayOfVertex[i][0]
            removeVertex(v)
            
            //set degree distribution array
            degreeForVertexArray![v.id] = self.vertices[v.id].degree
            degreeWhenDeleteArray![v.id] = v.degree
            
            s.push(v)
            degreeGroupWithArrayOfVertex[i].remove(at: 0)
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
            usedColor.sort()
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
