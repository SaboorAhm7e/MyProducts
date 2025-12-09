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
    @State var path = NavigationPath()
    @State var finalDataSet : [ProductModel] = []
    var body: some View {
        NavigationStack(path: $path){
            ScrollView(.vertical,showsIndicators: false){
                LazyVGrid(columns: columns) {
                    ForEach(finalDataSet) { product in
                        NavigationLink(value: product.id) {
                            HomeGridItem(product: product)
                                .tint(.primary)
                        }
                        .accessibilityIdentifier("navigation_link_tap")
                      
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                viewModel.fetchAllProducts()
            }
            .onChange(of: viewModel.products) { _, _ in
                finalDataSet = viewModel.products
            }
            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu("", systemImage: "arrow.up.arrow.down") {
                        Text("Sort")
                        Divider()
                        Button("A-Z"){
                            finalDataSet = SortManager.sortInAscendingOrder(viewModel.products)
                        }
                        Button("Z-A"){
                            finalDataSet = SortManager.sortInDescendingOrder(viewModel.products)
                        }
                        Button("Price: High-Low"){
                            finalDataSet = SortManager.sortInHightToLowPrice(viewModel.products)
                        }
                        Button("Price: Low-High") {
                            finalDataSet = SortManager.sortInLowToHighPrice(viewModel.products)
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { id in
                ItemDetailView(id: id)
                    .environmentObject(viewModel)
            }
        }
        
    }

}

#Preview {
    HomeView()
}
