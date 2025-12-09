//
//  SortManagerTest.swift
//  MyProducts
//
//  Created by saboor on 09/12/2025.
//

import Testing

@testable import MyProducts

struct SortManagerTest {
    

    // MARK: - Validation
    @Suite("SortManager Validation")
    struct Validation {
        private let arr : [ProductModel] = [
            .init(id: 1, title: "bag", price: 30, description: "hand cary bag", category: "lady", image: ""),
            .init(id: 2, title: "jacket", price: 50, description: "lather crafted", category: "man", image: ""),
            .init(id: 3, title: "laptop", price: 100, description: "macbook pro 16/512", category: "man", image: ""),
            .init(id: 4, title: "perfume", price: 70, description: "night walker", category: "lady", image: ""),
        ]
        @Test func sortAtoZ()  {
            // arrange
            let sorted = SortManager.sortInAscendingOrder(arr)
            // expect
            let sortedTitle = ["bag","jacket","laptop","perfume"]
            #expect(sorted.map(\.title) == sortedTitle)
        }
        @Test func sortZtoA()  {
            // arrange
            let sorted = SortManager.sortInDescendingOrder(arr)
            // expect
            let sortedTitle = ["perfume","laptop","jacket","bag"]
            #expect(sorted.map(\.title) == sortedTitle)
        }
        @Test func sortHightoLow()  {
            // arrange
            let sorted = SortManager.sortInHightToLowPrice(arr)
            // expect
            let sortedPrice : [Double] = [100,70,50,30]
            #expect(sorted.map(\.price) == sortedPrice)
        }
        @Test func sortLowtoHigh()  {
            // arrange
            let sorted = SortManager.sortInLowToHighPrice(arr)
            // expect
            let sortedPrice : [Double] = [30,50,70,100]
            #expect(sorted.map(\.price) == sortedPrice)
        }
    }
    
    // MARK: - Performance
    @Suite("SortManager Performance")
    struct Performance {
        private func generateLargeList(count:Int) -> [ProductModel] {
            (0..<count).map { i in
                ProductModel(id: i,
                             title: "Item \(Int.random(in: 0...10_000))",
                             price: Double.random(in: 0...10_000),
                             description: "desc",
                             category: "cat",
                             image: ""
                )
            }
        }
        private func measure(_ block:() -> Void) -> Duration {
            let clock = ContinuousClock()
            return clock.measure {
                block()
            }
        }
        
        @Test func performanceSortAToZ()  {
            let arr = generateLargeList(count: 50_000)
            let time =  measure {
                _ = SortManager.sortInAscendingOrder(arr)
            }
            #expect(time < .seconds(0.15))
        }
        
        @Test func performanceSortZToA()  {
            let arr = generateLargeList(count: 50_000)
            let time =  measure {
                _ = SortManager.sortInDescendingOrder(arr)
            }
            #expect(time < .seconds(0.15))
        }
        
        @Test func performanceSortHighToLow()  {
            let arr = generateLargeList(count: 50_000)
            let time =  measure {
                _ = SortManager.sortInHightToLowPrice(arr)
            }
            #expect(time < .seconds(0.15))
        }
        
        @Test func performanceSortLowToHigh()  {
            let arr = generateLargeList(count: 50_000)
            let time =  measure {
                _ = SortManager.sortInLowToHighPrice(arr)
            }
            #expect(time < .seconds(0.15))
        }
        
    }
    


}
