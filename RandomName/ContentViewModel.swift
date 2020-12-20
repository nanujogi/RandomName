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
            print("Participants count : \(namesLoaded.count)\nTap Search Lucky Button\nPlease wait for completion message...\n")
        }
        
        func selectLucky() {
            
            self.randomNameArray.removeAll() // clear array before start fresh again in case we did not find an winner in first attempt.
            
            let pub = Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .map { _ in
                    self.namesLoaded.randomElement()
                }
                .prefix(115) // giving fair chance to everyone.
            
            
            let subscriptions = pub.sink(receiveCompletion: { _ in print ("\nCompletions called, now tap Winners to get list of winners names with count, how many times the lucky names were called randomly.")
               
            }, receiveValue: { values in
                self.randomNameArray.append(values!.name)
                print("randomly selected names \(values!.name)")
            })
            .store(in: &cancellable)
        }
        
        func printLucky() {
            var winner = Winner<String>()
            for name in randomNameArray.sorted(){
                winner.insert(name)
            }
            print(winner.description)
            
            // we split it to array so that we can filter winner.
            let temp = winner.description.split(separator: "\n")
            
            // Participants who's names got selected 4 times is the winner :)
            let luckyUser = temp.filter { (str) -> Bool in
                str.range(of: "4 times", options: .caseInsensitive) != nil
            }
            
            if !luckyUser.isEmpty {
                print("Winner is : \(luckyUser)")
                print("Final winner will be choosen by Ben Scheirman !!")
            } else {
                print("Ooops... please retry no winner found.")
            }
        }
    }
}
