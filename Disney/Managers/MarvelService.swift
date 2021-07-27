//
//  MarvelService.swift
//  Disney
//
//  Created by Pierre Moreau on 7/25/21.
//

import Foundation
import CryptoKit


class MarvelService {
    
    func retreiveContent<T>(path: String,
                            successCompletion: @escaping (T) -> Void,
                            errorCompletion: @escaping (MarvelError) -> Void) where T: Decodable {
        
        //Generate parameters (Timestamp and HASH)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd_HH:mm:ss.SSSS"
        let timestamp = format.string(from: Date())
        let hash = generateHash(date: timestamp, publicKey: marvelPublicKey, privateKey: marvelPrivateKey)
        
        //Format request
        let urlString = "\(marvelDomain)v1/public/\(path)?ts=\(timestamp)&apikey=\(marvelPublicKey)&hash=\(hash)"
        guard let url = URL(string: urlString) else {
            errorCompletion(.invalidUrl)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        //Send request
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            if let data = data,
               let expectedObject = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async { successCompletion(expectedObject) }
            }
            else {
                let error = try? JSONDecoder().decode(MarvelError.self, from: data ?? Data())
                DispatchQueue.main.async { errorCompletion(error ?? .generic) }
            }
        }).resume()
    }
    
    func generateHash(date: String, publicKey: String, privateKey: String) -> String {
        let content = date + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: content.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
