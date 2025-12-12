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
    @EnvironmentObject var viewModel : ProductViewModel
    
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
            .accessibilityIdentifier("item_detail_image")
            VStack(alignment:.leading){
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .accessibilityIdentifier("item_detail_title")
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("item_detail_price")
                Text(item.description)
                    .accessibilityIdentifier("item_detail_desc")
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
            item = await viewModel.fetchDetail(id: id)
        }
        
    }
}

#Preview {
    ItemDetailView()
}
