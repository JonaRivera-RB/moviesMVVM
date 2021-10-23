//
//  LoginUseCase.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct LoginUseCase {
    
    static func request(loginModel: LoginModel, _ completion: @escaping (_ errorAPI: ErrorResponse?, _ response: TokenResponse?) -> () ) {
        
        let postRequest = PostDataHttp()
        postRequest.url = URL(string: AppConstans.URL + AppConstans.LOGIN + AppConstans.API_KEY)
        postRequest.header = false
        postRequest.paramString = loginModel.asDictionary
        postRequest.forData { (data, error, success) in
            if success {
                if let data = data, let token = DataFetcher<TokenResponse>().getData(data: data) {
                    completion(nil, token)
                    return
                }
            }else {
                if let data = data, let errorAPI = DataFetcher<ErrorResponse>().getData(data: data) {
                    completion(errorAPI, nil)
                    return
                }
            }
            
            completion(ErrorResponse(statusMessage: "Error no conocido", statusCode: nil), nil)
            return
        }
    }
}
