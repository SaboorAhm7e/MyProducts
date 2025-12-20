//
//  MainTabView.swift
//  MyProducts
//
//  Created by saboor on 16/12/2025.
//

import SwiftUI
import SwiftData

enum TabCase : Hashable {
    case home
    case cart
    case search
}

struct MainTabView: View {
    @State var currentTab : TabCase = .home
    @StateObject var viewModel : ProductViewModel = ProductViewModel(service: NetworkManager())
    @State var showAlert : Bool = false
    @Query var products : [ProductPersistantModel]
    var body: some View {
        TabView(selection:$currentTab) {
            Tab("Home", systemImage: "house",value: .home) {
                HomeView(selectedTab:$currentTab)
                    .environmentObject(viewModel)
            }
            Tab("Cart", systemImage: "cart",value: .cart) {
                CartView()
                    
            }
            .badge(products.count)
            Tab(value:.search,role:.search) {
                HomeView(selectedTab:$currentTab)
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.fetchAllProducts()
        }
        .onChange(of: viewModel.errorMessage, { _, new in
            if !new.isEmpty {
                showAlert.toggle()
            }
        })
        .alert(viewModel.errorMessage, isPresented: $showAlert) {
            Button("OK",role:.cancel){}
        }
    }
}

#Preview {
    MainTabView()
}
