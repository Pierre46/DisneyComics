//
//  ComicsManager.swift
//  Disney
//
//  Created by Pierre Moreau on 7/25/21.
//

import UIKit

class ComicsManager {
    var service = MarvelService()
        
    func retreiveComic(id: Int,
                       successCompletion: @escaping (Comic) -> (),
                       errorCompletion: @escaping (MarvelError) -> ()) {
        
        service.retreiveContent(path: "comics/\(id)",
                                successCompletion: { (response: ComicResponse) in
            
            guard let comic = response.data.results.first else {
                errorCompletion(.generic)
                return
            }
                                    
            successCompletion(comic)
        },
        errorCompletion: errorCompletion)
    }
}

private struct ComicResponse: Decodable {
    var data: DataResponse
}

private struct DataResponse: Decodable {
    var results: [Comic]
}
