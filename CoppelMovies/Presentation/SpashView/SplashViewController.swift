//
//  SplashViewController.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    //MARK: - Properties
    private var viewModel: SplashViewModel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewModel()
    }
    
    //MARK: - Functions
    private func initViewModel() {
        viewModel = SplashViewModel()
        bind()
        viewModel.getNewToken()
    }
    
    private func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            if let errorAPI = error {
                self?.showAlert(alertText: AppConstans.Errors.GENERIC_ERROR_TITLE, alertMessage: errorAPI.statusMessage)
            }
        }
        
        viewModel.tokenResponse.observe(on: self) { [weak self] result in
            if result == true {
                if Memory.memory.getUserIsLogged() {
                    self?.navigationToMainView()
                }else {
                    self?.navigateToLoginView()
                }
            }
        }
    }
    
    //MARK: - Navigation
    private func navigateToLoginView() {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let navigationController = UINavigationController(rootViewController: initialViewController)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.rootViewController = navigationController
        keyWindow?.makeKeyAndVisible()
    }
    
    private func navigationToMainView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let navigationController = UINavigationController(rootViewController: initialViewController)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.rootViewController = navigationController
        keyWindow?.makeKeyAndVisible()
    }
    
}
