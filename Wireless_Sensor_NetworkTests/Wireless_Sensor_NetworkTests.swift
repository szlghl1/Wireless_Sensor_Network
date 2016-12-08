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
        let d = 10; let nV:Int = 4000
        let upperD = Double(d) * 1.1
        let lowerD = Double(d) * 0.9
        let testDisk = Disk(avgDegree: d, numberOfVertices: nV)
        XCTAssert(testDisk.avgDegree > lowerD && testDisk.avgDegree < upperD)
        print("avgDegree = ", testDisk.avgDegree)
        print("num of used color = ", testDisk.numColor)
        let testSphere = Sphere(avgDegree: d, numberOfVertices: nV)
        XCTAssert(testSphere.avgDegree > lowerD && testSphere.avgDegree < upperD)
        print("avgDegree = ", testSphere.avgDegree)
        print("num of used color = ", testSphere.numColor)
        let testSquare = Square(avgDegree: d, numberOfVertices: nV)
        XCTAssert(testSquare.avgDegree > lowerD && testSquare.avgDegree < upperD)
        print("avgDegree = ", testSquare.avgDegree)
        print("num of used color = ", testSquare.numColor)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
