//
//  ContentView.swift
//  RandomName
//
//  Created by Nanu Jogi on 18/12/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewmodel = ViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewmodel.namesLoaded, id:\.id) { names in
                    Text("\(names.name)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            Button("Search Lucky") {
                viewmodel.selectLucky()
                
            }
            
            Button("Winners") {
                viewmodel.printLucky()
            }
        }
    }
}


