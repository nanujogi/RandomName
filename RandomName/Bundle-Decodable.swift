//
//  Bundle-Decodable.swift
//  Moonshot
// Paul Hudson www.hackingwithswift.com

import Foundation
import SwiftUI

extension Bundle {
    func decode<T: Codable>(file: String, myfolder: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil, subdirectory: myfolder) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
