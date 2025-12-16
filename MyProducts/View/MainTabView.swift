//
//  MainTabView.swift
//  MyProducts
//
//  Created by saboor on 16/12/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house", role: .none) {
                Text("Home")
            }
            Tab("Cart", systemImage: "cart", role: .none) {
                Text("Cart")
            }
            Tab("Search",systemImage: "magnifyingglass",role: .search) {
                Text("Searching")
            }
        }
    }
}

#Preview {
    MainTabView()
}
