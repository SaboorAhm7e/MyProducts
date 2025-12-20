//
//  ContentView.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI
import SwiftData

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
    @Environment(\.modelContext) var context
    @State var showDataAlert : Bool = false
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
                                        addToCart(product: product)
                                    }
                                    .tint(.blue)
                                    
                                }
                        }
                        .accessibilityIdentifier("navigation_link_tap")
                        
                    }
                }
                .padding(.horizontal)
                
            }
            .alert("Successfuly added to cart", isPresented: $showDataAlert) {
                Button("OK", role: .cancel) { }
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
    // MARK: - methods
    func addToCart(product:ProductModel) {
        
        let model = ProductPersistantModel(id: product.id, title: product.title, price: product.price, desc: product.description, category: product.category, image: product.image)
        context.insert(model)
        showDataAlert.toggle()
        
    }

}

#Preview {
    HomeView(selectedTab: .constant(TabCase.home))
}
