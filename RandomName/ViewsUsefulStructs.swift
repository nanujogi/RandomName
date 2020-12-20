//
//  ViewsUsefulStructs.swift
//  Recepies


import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding(10)
            .background(Color.blue)
            .cornerRadius(8)
    }
}


