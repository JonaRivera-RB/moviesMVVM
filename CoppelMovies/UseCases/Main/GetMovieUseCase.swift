//
//  GetMovieUseCase.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct GetMovieUseCase {
    
    static func request(section: String, _ completion: @escaping (_ errorAPI: ErrorResponse?, _ response: MovieModel?) -> () ) {
        
        let getRequest = GetDataHttp()
        getRequest.url = URL(string: AppConstans.URL + "\(section)" + "?api_key=" + AppConstans.API_KEY + "&language=es-MX&page=1")
        getRequest.header = false
        getRequest.forData { (data, error, success) in
            if let data = data, let token = DataFetcher<MovieModel>().getData(data: data) {
                completion(nil, token)
                return
            }else{
                if let data = data, let errorAPI = DataFetcher<ErrorResponse>().getData(data: data) {
                    completion(errorAPI, nil)
                    return
                }
                
                completion(ErrorResponse(statusMessage: "Error no conocido", statusCode: nil), nil)
                return
            }
        }
    }
}
