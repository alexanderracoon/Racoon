//
//  CoverCache.swift
//  Racoon
//
//  Created by Александр Переславцев on 21.05.2026.
//

import UIKit

actor CoverCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    func data(url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
        
    }
    
    func insert(image: UIImage, url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    func remove(for url: URL) {
        cache.removeObject(forKey: url as NSURL)
    }

    func removeAll() {
        cache.removeAllObjects()
    }
}

