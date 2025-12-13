//
//  PVMTest.swift
//  Test
//
//  Created by saboor on 07/12/2025.
//

import Testing

@testable import MyProducts

struct PVMTest  {

    var viewModel : ProductViewModel?
    
    init() {
        viewModel = ProductViewModel(service: MockNetworkManager())
    }
    
    @Test("View Model->fetchAllProducts") func fetchAllProducts()  {
        viewModel?.fetchAllProducts()
        #expect(viewModel?.products.isEmpty == true,"product must be empty")
    }
    @Test("View Model->fetchProductDetail") func fetchDetail() async {
        // arrange
        let id = 1
        // act
        let product = await viewModel?.fetchDetail(id: id)
        // expect
        #expect(product == ProductModel.dummy,"fetch detail not equal")
    }
    @Test("View Model->deleteProduct") func deleteProduct() async{
        // arragne
        let id = 1
        // act
        await viewModel?.deleteProduct(id: id)
        let message = await viewModel?.errorMessage
        // expect
        #expect(message == "Successfuly delete product")
    }
    @Test("View Model -> addProduct")
    func addProduct() async throws {
        // arrange
        let product : ProductModel = ProductModel(id: 1, title: "", price: 0, description: "", category: "", image: "")
        // act
        await viewModel?.addProduct(product: product)
        let message = await viewModel?.errorMessage
        // expect
        #expect(message == "Successfuly add product")
    }
 
    

}
