//
//  ContentViewModel.swift
//  RandomName
//
//  Created by Nanu Jogi on 18/12/20.
//

import Foundation
import SwiftUI
import Combine

extension ContentView {
    
    class ViewModel: ObservableObject {
       
        var namesLoaded:[Users]
        var cancellable = Set<AnyCancellable>()
        var nameSelected: String = ""
        @Published var randomNameArray = [String]()
         
        init() {
         namesLoaded = Bundle.main.decode(file: "participants.json", myfolder: "alljson")
            print("Participants count : \(namesLoaded.count)\nTap Search Lucky Button\nPlease wait for completion message")
        }
        
        func selectLucky() {
            let pub = Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .map { _ in
                    self.namesLoaded.randomElement()
                }
                .prefix(115) // giving fair chance to everyone.

                
            let subscriptons = pub.sink(receiveCompletion: { _ in print ("Completions called, now tap Winners to get list of winners names with count how many times the lucky names were called randomly.")}, receiveValue: { values in
//               print("\(String(describing: values!.name))")
                self.randomNameArray.append(values!.name)
            })
            .store(in: &cancellable)
        }
        
        func printLucky() {
           var winner = Winner<String>()
            for name in randomNameArray.sorted(){
//                print(name)
                winner.insert(name)
            }
            
            print(winner)
            print("Final winner will be choosen by Ben Scheirman !!")
        }
       
    }
}
