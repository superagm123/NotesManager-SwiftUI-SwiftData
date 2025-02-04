//
//  FloatingActionButton.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct FloatingActionButton: View {
    
    let icon: String
    let color: Color
    let action: () -> Void
    
    @State private var opacity: Double = 1
    
    var body: some View {
        Circle()
            .fill(color.gradient)
            .frame(width: 75, height: 75)
            .overlay{
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(.white)
                    .contentTransition(.symbolEffect(.replace))
            }
            .shadow(radius: 3)
            .opacity(opacity)
            .onTapGesture{
                withAnimation(.linear(duration: 0.1)){
                    opacity = 0.2
                }
                
                action()
                
                withAnimation(.linear(duration: 0.1).delay(0.1)){
                    opacity = 1
                }
            }
            .padding([.bottom, .trailing], 20)
    }
}

#Preview {
    FloatingActionButton(icon: "plus", color: .green){
        
    }
}
