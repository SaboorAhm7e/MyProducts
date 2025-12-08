//
//  ItemDetailView.swift
//  MyProducts
//
//  Created by saboor on 08/12/2025.
//

import SwiftUI

struct ItemDetailView: View {
    var id : Int = 1
    @State private var item : ProductModel = .dummy
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: item.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    ProgressView()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.separator)
                }
            }
            .frame(width:200,height: 200)
            VStack(alignment:.leading){
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                Text(item.description)
            }
           
            
            Spacer()

        }
        .overlay(alignment: .topTrailing, content: {
                Text(item.category)
                .font(.footnote)
                .padding(.horizontal,5)
                .padding(.vertical,3)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.separator)
                    )
            .offset(y:-2)
        })
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("", systemImage: "cart") {
                    //
                }
            }
        }
        .task {
            do {
                item = try await fetch(id: id)
            } catch let error as NetworkError {
                print(error.message)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    func fetch(id:Int) async throws -> ProductModel {
        let endpoint = "https://fakestoreapi.com/products/\(id)"
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                throw NetworkError.serverError
            }
            return try JSONDecoder().decode(ProductModel.self, from: data)
            
        } catch let error as DecodingError {
            throw NetworkError.networkError(error: error.localizedDescription)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error: error.localizedDescription)
        }
    }
}

#Preview {
    ItemDetailView()
}
