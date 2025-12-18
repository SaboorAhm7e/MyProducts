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
    @EnvironmentObject var viewModel : ProductViewModel
    @Environment(\.horizontalSizeClass) var hsizeclass
    var isIpad : Bool {
        hsizeclass == .regular
    }
    var columns : [GridItem] {
        Array(repeating: GridItem(.flexible()), count: isIpad ? 3 : 2)
    }
    @State var path = NavigationPath()
    var finalDataSet : [ProductModel] {
        if searchText.isEmpty { return viewModel.products}
        return viewModel.products.filter{$0.title.localizedCaseInsensitiveContains(searchText)}
    }
    @State var searchText = ""
    @Binding var selectedTab: TabCase
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
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.automatic)
            .searching(tabCase: $selectedTab, txt: $searchText)
            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        path.append(NavigationRute.add)
                    }
                    toolBarMenu()
                }
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
        }
        
    }
    // MARK: - Subviews
    @ViewBuilder
    private func  toolBarMenu() -> some View {
        Menu("", systemImage: "arrow.up.arrow.down") {
            Text("Sort")
            Divider()
            Button("Order: A-Z"){
                withAnimation(.easeInOut) {
                    viewModel.products = SortManager.sortInAscendingOrder(viewModel.products)
                }
                
            }
            Button("Order: Z-A"){
                withAnimation(.easeInOut) {
                    viewModel.products = SortManager.sortInDescendingOrder(viewModel.products)
                }
            }
            Button("Price: High-Low"){
                withAnimation(.easeInOut) {
                    viewModel.products = SortManager.sortInHightToLowPrice(viewModel.products)
                }
            }
            Button("Price: Low-High") {
                withAnimation(.easeInOut) {
                    viewModel.products = SortManager.sortInLowToHighPrice(viewModel.products)
                }
            }
        }
    }

}

#Preview {
    HomeView(selectedTab: .constant(TabCase.home))
}
