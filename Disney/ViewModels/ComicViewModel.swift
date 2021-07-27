//
//  ComicViewModel.swift
//  Disney
//
//  Created by Pierre Moreau on 7/25/21.
//

import UIKit
import Combine


enum ComicLoadingState { case idle, loading, success(comic: Comic), failure(error: MarvelError) }

class ComicViewModel {
    
    var service = ComicsManager()
    var comicState = CurrentValueSubject<ComicLoadingState, MarvelError>(.idle)
    var comicThumbnailImage = PassthroughSubject<UIImage, Error>()
    
    func loadComic() {
        comicState.send(.loading)
        
        service.retreiveComic(id: comicId, successCompletion: { [weak self] comic in
            
            self?.comicState.send(.success(comic: comic))
            if let thumbnailUrl = comic.thumbnail {
                self?.loadThumbnail(url: thumbnailUrl)
            }
        },
        errorCompletion: { [weak self] error in
            self?.comicState.send(.failure(error: error))
        })
    }
    
    func loadThumbnail(url: URL) {
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            [weak self] data, response, error in

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { self?.comicThumbnailImage.send(image) }
            }
        }).resume()
    }
}
