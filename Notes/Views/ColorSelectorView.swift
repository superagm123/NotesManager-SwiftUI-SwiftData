//
//  ColorSelectorView.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct ColorSelectorView: View {
    
     var colors: [Color] = [
        .teal, .green, .yellow, .orange, .pink, .purple, .brown
    ]
    
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack{
            ForEach(colors, id: \.self){color in
                Circle()
                    .fill(color.gradient)
                    .frame(width: 40, height: 40)
                    .overlay(selectedColor == color ? Circle().stroke(.black, lineWidth: 1) : nil)
                    .onTapGesture{
                        selectedColor = color
                    }
            }
        }
    }
}

#Preview {
    ColorSelectorView(selectedColor: .constant(.teal))
}
