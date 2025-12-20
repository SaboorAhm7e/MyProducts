//
//  CartView.swift
//  MyProducts
//
//  Created by saboor on 19/12/2025.
//

import SwiftUI
import SwiftData

struct CartView: View {
    @Query var cartProducts : [ProductPersistantModel]
    @State var deleteBtnTap: Bool = false
    @State var productToDelete : [ProductPersistantModel] = []
    var body: some View {
        NavigationStack{
            VStack {
                if cartProducts.isEmpty {
                    ContentUnavailableView("Cart is Empty", systemImage: "cart")
                } else {
                    List {
                        ForEach(cartProducts){ product in
                            CartItemView(product: product, deleteBtnTap: $deleteBtnTap)
                                
                        }
                    }
                    .listRowSpacing(10)
                }
            }
            
           
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("", systemImage: "trash") {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            deleteBtnTap.toggle()
                        }
                    }
                    .tint(deleteBtnTap ? .red : nil)
                }
            }
        }
    }
}

struct CartItemView : View {
    var product : ProductPersistantModel
    @Binding var deleteBtnTap: Bool
    @Environment(\.modelContext) var context
    var body: some View {
        HStack {
            if deleteBtnTap {
                
                Button {
                    context.delete(product)
                    deleteBtnTap.toggle()
                } label: {
                   Image(systemName: "minus.circle")
                        .imageScale(.large)
                        .foregroundStyle(.red)
                        .symbolEffect(.bounce, options: .repeat(.continuous))
                }

                
            }
            
            
            
            if let url = URL(string: product.image) {
                CachedImageView(url: url)
                    .scaledToFit()
                    .frame(width: 80,height: 80)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary)
                    .frame(width: 80,height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .lineLimit(2)
                
                Spacer()
                HStack(spacing:8) {
                    Text("$\(String(format:"%.2f", product.price))")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
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
                    .disabled(product.quantity == 1)
                    
                    Text("\(product.quantity)")
                    

                    
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
}

#Preview {
    CartView()
}
