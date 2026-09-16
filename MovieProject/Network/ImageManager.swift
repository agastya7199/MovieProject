//
//  ImageManager.swift
//  MovieProject
//
//  Created by Mouli Agastya on 9/15/26.
//

import UIKit

class ImageManager {
    // MARK: - Properties
    
    static let imageCache = NSCache<NSURL, UIImage>()
        
    static func downloadImageFromCache(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let nsURL = url as NSURL
        
        // MARK: - Return cached image if available
        
        if let cachedImage = imageCache.object(forKey: nsURL) {
            completion(cachedImage)
            return
        }
        
        // MARK: - Fetch from API
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // MARK: - Check for valid data & convert to image
            
            guard let data = data, let image = UIImage(data: data), error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            // MARK: - Save to cache & return on main thread
            
            imageCache.setObject(image, forKey: nsURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
