//
//  CoverProxy.swift
//  Racoon
//
//  Created by Александр Переславцев on 22.05.2026.
//

import UIKit


actor CoverProxy {
    private let cache = CoverCache()
    
    static let shared = CoverProxy()
    
    func loadData(url: URL) async throws -> UIImage {
        
        if let cached = await cache.data(url: url) {
            return cached
        }
        
        let data = try Data(contentsOf: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        await cache.insert(image: image, url: url)
        
        return image
    }
}
