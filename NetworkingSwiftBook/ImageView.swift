//
//  ImageView.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 17.09.2021.
//

import UIKit

class ImageView: UIImageView {
    
    func fetchImage(with url: String?) {
        
        guard let url = url else { return }
        guard let imageUrl = url.getUrl() else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        // Если изображение есть в кеше, то используем его
        
        if let cachedImage = getCachedImage(url: imageUrl) {
            image = cachedImage
            return
        }
        
//        URLSessionDataTask
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            
            if let error = error { print(error); return }
            guard let data = data, let response = response else { return }
            guard let responseUrl = response.url else { return }
            
            if responseUrl.absoluteString != url { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            // Сохраняем изображение в кеш
            
            self.saveImageToCache(data: data, response: response)
            
        }.resume()
        
    }
    
    private func saveImageToCache(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cashedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cashedResponse, for: URLRequest(url: responseUrl))
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cacheResponse.data)
        }
        
        return nil
    }
    
}

fileprivate extension String {
    func getUrl() -> URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
}
