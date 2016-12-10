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
    static var colorMap = [Int: (CGFloat,CGFloat,CGFloat)]()
    
    class func getColor(id: Int) -> UIColor
    {
        if colorMap[id] == nil
        {
            let r = CGFloat(drand48())
            let g = CGFloat(drand48())
            let b = CGFloat(drand48())
            colorMap[id] = (r, g, b)
        }
        let t = colorMap[id]!
        return UIColor(red: t.0, green: t.1, blue: t.2, alpha: 1)
    }
    
    class func getLineNode(v1: Vertex, v2: Vertex) -> SCNNode
    {
        let positions: [Float32] = [Float32(v1.x), Float32(v1.y), Float32(v1.z), Float32(v2.x), Float32(v2.y), Float32(v2.z)]
        let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
        let indices: [Int32] = [0, 1]
        let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
        
        let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
        let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
        
        let line = SCNGeometry(sources: [source], elements: [element])
        return SCNNode(geometry: line)
    }
    
    //the size is fixed. highlight vertices should be draw in another way
    class func getSphereNode(v: Vertex) -> SCNNode
    {
        let sphere = SCNSphere(radius: 0.03)
        sphere.firstMaterial?.diffuse.contents = getColor(v.color)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(v.x, v.y, v.z)
        return sphereNode
    }
}