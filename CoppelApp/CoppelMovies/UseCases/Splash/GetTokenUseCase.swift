//
//  GetTokenUseCase.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct GetTokenUseCase {
    
    static func request(_ completion: @escaping (_ errorAPI: ErrorResponse?, _ response: TokenResponse?) -> () ) {
        
        let getRequest = GetDataHttp()
        getRequest.url = URL(string: AppConstans.URL + AppConstans.NEW_TOKEN + AppConstans.API_KEY)
        getRequest.header = false
        getRequest.forData { (data, error, success) in
            if let data = data, let token = DataFetcher<TokenResponse>().getData(data: data) {
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
