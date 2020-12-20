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
        NavigationView {
            VStack {
                List {
                    ForEach(viewmodel.namesLoaded, id:\.id) { names in
                        Text("\(names.name)")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                
                HStack {
                    Button("Search Lucky") {
                        viewmodel.selectLucky()
                        
                    }
                    .buttonStyle(BlueButton())
                    
                    Button("Winners") {
                        viewmodel.printLucky()
                    }
                    .buttonStyle(BlueButton())
                }
            }
            .navigationBarTitle("Participants", displayMode: .inline)
        }
    }
}


