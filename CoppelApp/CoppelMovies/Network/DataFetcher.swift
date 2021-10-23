//
//  DataFetcher.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation

class DataFetcher<T> where T: Decodable {
    func getData(data :Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let e {
            print("dataString = \(NSString(data: data, encoding:String.Encoding.utf8.rawValue)!) and error \(e)")
            return nil
        }
    }
}
