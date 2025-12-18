//
//  SearchBarDisplay.swift
//  MyProducts
//
//  Created by saboor on 18/12/2025.
//

import SwiftUI

struct Searching : ViewModifier {
    @Binding var tabCase : TabCase
    @Binding var searchText : String
    func body(content: Content) -> some View {
        switch tabCase {
        case .home,.cart:
            content
        case .search:
            content
                .searchable(text: $searchText)
        }
    }
}
