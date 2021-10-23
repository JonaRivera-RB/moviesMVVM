//
//  MainViewController.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak private(set) var moviesCollectionView: UICollectionView!
    @IBOutlet weak private(set) var sectionsSegment: UISegmentedControl!
    
    //MARK: - Properties
    private var viewModel: MainViewModel!
    private var loadingView: UIAlertController!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        bind()
        
        setupUI()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    //MARK: - functions
    private func bind() {
        viewModel.error.observe(on: self) { [weak self] (error) in
            self?.loadingView?.dismiss(animated: true, completion: {
                if let errorAPI = error {
                    print("some errro \(errorAPI.statusMessage)")
                }
            })
        }
        
        viewModel.loginResponse.observe(on: self) { [weak self] result in
            self?.loadingView?.dismiss(animated: true, completion: {
                
                if result == true {
                    self?.moviesCollectionView.reloadData()
                }
            })
        }
    }
    
    
    private func setupNavigationColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .darkGray
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    private func setupUI() {
        setupNavigationColor()
        
        loadingView = loadingView()
        
        for (index, option) in viewModel.getSections().enumerated() {
            sectionsSegment.setTitle(option, forSegmentAt: index)
        }
        
        sectionsSegment.selectedSegmentIndex = 0
        indexSelected(sender: sectionsSegment)
    }
    
    private func goToProfileView() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
        guard let profileViewController = storyboard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController else { return }
        
        present(profileViewController, animated: true, completion: nil)
    }
    
    private func logOut() {
        Memory.memory.userIsLogged(isLogged: false)
        
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let navigationController = UINavigationController(rootViewController: initialViewController)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.rootViewController = navigationController
        keyWindow?.makeKeyAndVisible()
    }
    
    //MARK: - IBActions
    @IBAction func indexSelected(sender: UISegmentedControl) {
        viewModel.setupStatusForPetition(index: sender.selectedSegmentIndex)
        
        if viewModel.verifyIfIsNeededDoRequest() {
            present(loadingView, animated: true, completion: nil)
            viewModel.getMovies()
        }else {
            moviesCollectionView.reloadData()
        }
    }
    
    @IBAction func openOptionsBtnWasPressed() {
        let alertView = UIAlertController(title: "what do you want to do?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let viewProfile = UIAlertAction(title: "View profile", style: .default) { (action: UIAlertAction) in
            self.goToProfileView()
        }
        
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { (action: UIAlertAction) in
            self.logOut()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertView.addAction(viewProfile)
        alertView.addAction(logOutAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.IDENTIFIER, for: indexPath) as? MovieCell else { fatalError() }
        
        cell.movie = viewModel.getMovie(with: indexPath.row)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)
        return CGSize(width: width / 2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
