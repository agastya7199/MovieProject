//
//  Extension.swift
//  SettingsPractice
//
//  Created by Mouli Agastya on 9/8/26.
//

import UIKit

extension UIImageView {
    // MARK: - Downloading Image with cache
    
    func downloadImage(from urlString: String) {
        
        // MARK: - Tag the view with the URL so we can verify it later
        self.accessibilityIdentifier = urlString
        
        // MARK: - Setting Placeholder Image
        self.image = UIImage(systemName: Constant.defaultImage.rawValue)
        
        guard let imageUrl = URL(string: urlString) else { return }
        
        // MARK: - Making call to the image manager
        ImageManager.downloadImageFromCache(for: imageUrl) { [weak self] downloadedImage in
            
            // MARK: - Attach the image to the UIImageView only if the accessibilityIdentifier matches
            
            if self?.accessibilityIdentifier == urlString {
                if let image = downloadedImage {
                    self?.image = image
                } else {
                    print("Failed to load image from: \(urlString)")
                }
            }
        }
    }
}
