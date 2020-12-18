//
//  names.swift
//  RandomName
//
//  Created by Nanu Jogi on 18/12/20.
//

import Foundation

struct Users: Codable, Identifiable {
    var id = UUID()
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

struct Winner<Element: Hashable> {
    private var store = [Element: Int]()
    
    mutating func insert(_ element: Element) {
        store[element, default: 0] += 1
    }
    
    var count: Int {
        return store.values.reduce(0, +)
        
    }
}

extension Winner: CustomStringConvertible {
    var description: String {
        var summary = String()
        for (key, value) in store {
            let times = value == 1 ? "time" : "times"
            summary.append("\(key) occurs \(value) \(times)\n")
        }
        return summary
    }
}



