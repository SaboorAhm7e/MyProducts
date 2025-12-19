//
//  CartView.swift
//  MyProducts
//
//  Created by saboor on 19/12/2025.
//

import SwiftUI

struct CartView: View {
    var product : ProductModel = .dummy
    var body: some View {
        NavigationStack{
            List {
                ForEach(0..<5,id: \.self){ i in
                    CartItemView(product: product)
                        
                }
            }
            .listRowSpacing(10)
            .navigationTitle("Cart")
        }
    }
}

struct CartItemView : View {
    var product : ProductModel
    @State var count : Int = 0
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 80,height: 80)
            VStack(alignment: .leading) {
                Text(product.title)
                    .lineLimit(2)
                Text("$\(String(format:"%.2f", product.price))")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
            HStack(spacing:8) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 25,height: 25)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                        )
                }
                
                Text("\(count)")
                

                
                Button {
                    //
                } label: {
                    Image(systemName: "minus")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 25,height: 25)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                        )
                }
                
            }
            
        }
    }
}

#Preview {
    CartView()
}
