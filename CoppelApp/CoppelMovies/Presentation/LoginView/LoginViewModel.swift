//
//  LoginViewModel.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation

final class LoginViewModel {
    //MARK: - Properties
    public var error: Observable<ErrorResponse?> = Observable(nil)
    public var loginResponse: Observable<Bool?> = Observable(nil)
    
    //MARK: - Logic
    public func loginRequest(with loginModel: LoginModel) {
        LoginUseCase.request(loginModel: loginModel) { [weak self] errorAPI, response in
            guard let self = self else { return }
            
            if let error = errorAPI {
                self.error.value = error
                return
            }
            
            Memory.memory.setToken(token: response?.requestToken)
            Memory.memory.userIsLogged(isLogged: true)
            self.loginResponse.value = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
