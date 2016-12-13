//
//  Draw
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/9.
//  Copyright © 2016年 LingHe. All rights reserved.
//

import Foundation
import SceneKit

class Draw {
    private static var colorMap = [Int: UIColor]()
    private static var geoDict = [Int: SCNGeometry]()//the key is color
    
    class func getColor(_ id: Int) -> UIColor
    {
        if colorMap[id] == nil
        {
            let r = CGFloat(drand48())
            let g = CGFloat(drand48())
            let b = CGFloat(drand48())
            colorMap[id] = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
        return colorMap[id]!
    }
    
    private static let oriRadius:Float = 0.02
    private static let firstGeo = SCNSphere(radius: CGFloat(oriRadius))
    class func getSphereNode(_ v: Vertex, r: Float) -> SCNNode
    {
        if geoDict[v.color ?? 0] == nil{
            //reuse the geometry, only create new material
            let g = firstGeo.copy() as! SCNGeometry
            let m = SCNMaterial()
            m.diffuse.contents = getColor(v.color ?? 0)
            g.firstMaterial = m
            
            //let g = SCNSphere(radius: CGFloat(oriRadius))
            //g.firstMaterial?.diffuse.contents = getColor(v.color ?? 0)
            geoDict[v.color ?? 0] = g
        }
        let sphereNode = SCNNode(geometry: geoDict[v.color ?? 0])
        sphereNode.position = SCNVector3Make(v.x, v.y, v.z)
        let scaleRatio = r / oriRadius
        sphereNode.scale = SCNVector3Make(scaleRatio, scaleRatio, scaleRatio)
        return sphereNode
    }
    //we have to draw all lines in one time to save memory
    //Thanks for http://stackoverflow.com/a/41101401/4672312
    class func getLinesNode(pathTupleArr: [(fromV:Vertex, toV:Vertex)]) -> SCNNode
    {
        if pathTupleArr.isEmpty{
            return SCNNode()
        }
        let getLinesNodeWithSubArr = {
            (pathTupleArr:[(fromV:Vertex, toV:Vertex)], from:Int, to:Int) -> SCNNode in
            var positions = [Float32]()
            for i in from...to{
                let t = pathTupleArr[i]
                positions.append(t.fromV.x)
                positions.append(t.fromV.y)
                positions.append(t.fromV.z)
                positions.append(t.toV.x)
                positions.append(t.toV.y)
                positions.append(t.toV.z)
            }
            let positionData = NSData(bytes: positions, length: MemoryLayout<Float32>.size*positions.count)
            let indices:[Int32] = Array(0..<(positions.count/3)).map({return Int32($0)})
            let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count)
            
            let source = SCNGeometrySource(data: positionData as Data, semantic: SCNGeometrySource.Semantic.vertex, vectorCount: indices.count, usesFloatComponents: true, componentsPerVector: 3, bytesPerComponent: MemoryLayout<Float32>.size, dataOffset: 0, dataStride: MemoryLayout<Float32>.size * 3)
            let element = SCNGeometryElement(data: indexData as Data, primitiveType: SCNGeometryPrimitiveType.line, primitiveCount: indices.count, bytesPerIndex: MemoryLayout<Int32>.size)
            
            let line = SCNGeometry(sources: [source], elements: [element])
            return SCNNode(geometry: line)
        }
        let res = SCNNode()
        let nLines = pathTupleArr.count
        //It is strange that if too many lines (like 300) in one node will cause crash.
        let sizeOfGroup = 250
        if nLines > sizeOfGroup{
            //0...199.size = 200
            let nStep:Int = Int(ceil(Float(nLines) / Float(sizeOfGroup)))
            for i in 0..<nStep{
                let from:Int = 0 + i * sizeOfGroup
                var to:Int = (sizeOfGroup - 1) + i * sizeOfGroup
                //last step
                if i == nStep - 1{
                    to = nLines - 1
                }
                let n = getLinesNodeWithSubArr(pathTupleArr, from, to)
                res.addChildNode(n)
            }
        }else{
            let n = getLinesNodeWithSubArr(pathTupleArr, 0, nLines-1)
            res.addChildNode(n)
        }
        return res
    }
}
