//
//  ImageManager.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 04.07.23.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {return}
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
}
