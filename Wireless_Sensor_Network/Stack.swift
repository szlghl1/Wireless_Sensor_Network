//
//  Stack.swift
//  Wireless_Sensor_Network
//
//  Created by LingHe on 16/12/7.
//  Copyright © 2016 LingHe. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}