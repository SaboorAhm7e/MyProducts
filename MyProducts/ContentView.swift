//
//  ContentView.swift
//  MyProducts
//
//  Created by saboor on 02/12/2025.
//

import SwiftUI

struct ProductModel  : Codable,Identifiable {
    let id : Int
    let title : String
    let price : Double
    let description : String
    let category : String
    let image : String
    
}

struct ContentView: View {
    @State var products : [ProductModel] = []
    var body: some View {
        List {
            ForEach(products) { product in
                HStack {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 90,height: 90)
                        
                    VStack(alignment: .leading) {
                        Text(product.title)
                        Text("$\(product.price)")
                    }
                }
            }
        }
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        let endpoint = "https://fakestoreapi.com/products"
        guard let url = URL(string: endpoint) else {
            return
        }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                return
            }
            
            guard let decoded = try? JSONDecoder().decode([ProductModel].self, from: data) else {
                return
            }
            products = decoded
            
        } catch {
            print("network error")
        }
    }
}

#Preview {
    ContentView()
}
