//
//  SplashViewModel.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation

final class SplashViewModel {
    //MARK: - Properties
    public var error: Observable<ErrorResponse?> = Observable(nil)
    public var tokenResponse: Observable<Bool?> = Observable(nil)
    
    //MARK: - Logic
    public func getNewToken() {
        GetTokenUseCase.request { [weak self] errorAPI, response in
            guard let self = self else { return }
            
            if let error = errorAPI {
                self.error.value = error
                return
            }
            
            Memory.memory.setToken(token: response?.requestToken)
            self.tokenResponse.value = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
