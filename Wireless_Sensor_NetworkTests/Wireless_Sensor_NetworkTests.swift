//
//  Wireless_Sensor_NetworkTests.swift
//  Wireless_Sensor_NetworkTests
//
//  Created by 凌何 on 16/12/7.
//  Copyright © 2016年 凌何. All rights reserved.
//

import XCTest
@testable import Wireless_Sensor_Network

class Wireless_Sensor_NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let d = 10; let nV:Int = 400
        let testDisk = Disk(avgDegree: d, numberOfVertices: nV)
        print("avgDegree = ", testDisk.avgDegree)
        let testSphere = Sphere(avgDegree: d, numberOfVertices: nV)
        print("avgDegree = ", testSphere.avgDegree)
        let testSquare = Square(avgDegree: d, numberOfVertices: nV)
        print("avgDegree = ", testSquare.avgDegree)

        
//        for v in testDisk.vertices
//        {
//            print("x = ", v.x, ", y = ", v.y, ", z = ", v.z)
//            //print("adjList = ",v.adjArray)
//        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
