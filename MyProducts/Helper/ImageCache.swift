//
//  ImageCache.swift
//  MyProducts
//
//  Created by saboor on 18/12/2025.
//

import Foundation
import UIKit
import SwiftUI
import Combine

final class ImageCache {
    static let shared = ImageCache()
    private init() { }
    
    private let cache = NSCache<NSURL,UIImage>()
    
    func image(for url:NSURL) -> UIImage?{
        cache.object(forKey: url)
    }
    func insert(image:UIImage,url:NSURL) {
        cache.setObject(image, forKey: url)
    }
}

final class ImageLoaderViewModel : ObservableObject {
    @Published var image : UIImage?
    
    private let url : URL
    private let cache = ImageCache.shared
    
    init(url: URL) {
        self.url = url
    }
    func load() async {
        let nsurl = url as NSURL
        // load from cache
        if let cacheImage = cache.image(for: nsurl) {
            self.image = cacheImage
            return
        }
        // download
        do {
            
            let (data,_) = try await URLSession.shared.data(from: url)
            if let uiimage = UIImage(data: data) {
                cache.insert(image: uiimage, url: nsurl)
                self.image = uiimage
            }
            
        } catch {
            print("error downloading image")
        }
        
    }
    
}

struct CachedImageView : View {
    @StateObject private var loaderViewModel : ImageLoaderViewModel
    init(url:URL) {
        _loaderViewModel = StateObject(wrappedValue: ImageLoaderViewModel(url: url))
    }
    var body: some View {
        Group {
            if let image = loaderViewModel.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ZStack {
                    ProgressView()
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.separator)
                }
            }
        }
        .task {
            await loaderViewModel.load()
        }
    }
}
