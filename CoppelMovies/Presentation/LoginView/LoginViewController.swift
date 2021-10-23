//
//  ViewController.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet private(set) weak var usernameLabel: UITextField!
    @IBOutlet private(set) weak var passwordLabel: UITextField!
    @IBOutlet private(set) weak var errorLabel: UILabel!
    
    private var viewModel: LoginViewModel!
    private var loadingView: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = loadingView()
        initViewModel()
    }
    
    //MARK: - Functions
    private func initViewModel() {
        viewModel = LoginViewModel()
        bind()
        
    }
    
    private func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            self?.loadingView?.dismiss(animated: true, completion: {
                if let errorAPI = error {
                    self?.updateLabelError(message: errorAPI.statusMessage)
                }
            })
        }
        
        viewModel.loginResponse.observe(on: self) { [weak self] result in
            self?.loadingView?.dismiss(animated: true, completion: {
                
                if result == true {
                    self?.navigateToLoginView()
                }
            })
        }
    }
    
    private func updateLabelError(message: String?) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    //MARK: - Navigation
    private func navigateToLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let navigationController = UINavigationController(rootViewController: initialViewController)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.rootViewController = navigationController
        keyWindow?.makeKeyAndVisible()
    }
    
    //MARK: - @IBAction
    @IBAction func loginBtnWasPressed() {
        guard let username = usernameLabel.text, username != "" else { return }
        guard let password = passwordLabel.text, password != "" else { return }
        
        present(loadingView, animated: true, completion: nil)
        viewModel.loginRequest(with: LoginModel(username: username, password: password, request_token: Memory.memory.getToken()))
    }
}

