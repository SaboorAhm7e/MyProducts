//
//  ContentView.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI

enum NavigationRute : Hashable {
    case detail(id: Int)
    case add
}

struct HomeView: View {
    // MARK: - properties
    @StateObject var viewModel : ProductViewModel = ProductViewModel(service: NetworkManager())
    var columns : [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    @State var path = NavigationPath()
    @State var finalDataSet : [ProductModel] = []
    @State var showAlert : Bool = false
    @State var searchText = ""
    // MARK: - body
    var body: some View {
        NavigationStack(path: $path){
            ScrollView(.vertical,showsIndicators: false){
                LazyVGrid(columns: columns) {
                    ForEach(finalDataSet) { product in
                        NavigationLink(value: NavigationRute.detail(id: product.id)) {
                            HomeGridItem(product: product)
                                .tint(.primary)
                                .contextMenu {
                                    Button("Delete", systemImage: "trash"){
                                        Task {
                                            await viewModel.deleteProduct(id: product.id)
                                        }
                                    }
                                    .tint(.red)
                                    Button("Add to Cart", systemImage: "cart"){
                                        print("cart")
                                    }
                                    .tint(.blue)
                                    
                                }
                        }
                        .accessibilityIdentifier("navigation_link_tap")
                        
                    }
                }
                .padding(.horizontal)
                
            }
            .onChange(of: viewModel.errorMessage, { _, new in
                if !new.isEmpty {
                    showAlert.toggle()
                }
            })
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                viewModel.fetchAllProducts()
            }
            .onChange(of: viewModel.products) { _, _ in
                finalDataSet = viewModel.products
            }
            .searchable(text: $searchText)
            .onChange(of: searchText, { oldValue, newValue in
                withAnimation(.easeInOut) {
                    searchData(newValue)
                }
                
            })
            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        path.append(NavigationRute.add)
                    }
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
            .navigationDestination(for: NavigationRute.self, destination: { rute in
                switch rute {
                case .detail(let id):
                    ItemDetailView(id:id)
                        .environmentObject(viewModel)
                case .add:
                    AddProductView()
                        .environmentObject(viewModel)
                }
            })
            .alert(viewModel.errorMessage, isPresented: $showAlert) {
                Button("OK",role:.cancel){}
            }
        }
        
    }
    
    func searchData(_ searchText: String) {
        
        if !searchText.isEmpty {
            finalDataSet = viewModel.products.filter {$0.title.lowercased().contains(searchText.lowercased())}
        } else {
            finalDataSet = viewModel.products
        }
        
    }

}

#Preview {
    HomeView()
}
