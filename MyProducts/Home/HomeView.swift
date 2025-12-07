//
//  ContentView.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI


struct HomeView: View {
    @StateObject var viewModel : ProductViewModel = ProductViewModel(service: NetworkManager())
    var columns : [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.products) { product in
                       HomeGridItem(product: product)
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.fetchAllProducts()
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        //
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
