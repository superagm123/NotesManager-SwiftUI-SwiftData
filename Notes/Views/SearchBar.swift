//
//  SearchBar.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
                .autocorrectionDisabled()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.primary.opacity(0.06), in: .rect(cornerRadius: 10))
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
