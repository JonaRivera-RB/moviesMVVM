//
//  MainViewModel.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

enum sections: CaseIterable {
    case Popular
    case TopRated
    case OnTV
    case AiringToday
    
    var description: String {
        switch self {
        case .Popular:
            return "movie/popular"
        case .TopRated:
            return "movie/top_rated"
        case .OnTV:
            return "tv/on_the_air"
        case .AiringToday:
            return "tv/airing_today"
        }
    }
    //https://api.themoviedb.org/3/movie/popular?api_key=634b49e294bd1ff87914e7b9d014daed&language=en-US&page=1
    //https://api.themoviedb.org/3/movie/top_rated?api_key=634b49e294bd1ff87914e7b9d014daed&language=en-US&page=1
    //https://api.themoviedb.org/3/tv/on_the_air?api_key=634b49e294bd1ff87914e7b9d014daed&language=en-US&page=1
    //https://api.themoviedb.org/3/tv/airing_today?api_key=634b49e294bd1ff87914e7b9d014daed&language=en-US&page=1
}

final class MainViewModel {
    //MARK: - Properties
    public var error: Observable<ErrorResponse?> = Observable(nil)
    public var loginResponse: Observable<Bool?> = Observable(nil)
    
    private let sectionsArray = ["Popular", "Top Rated", "On TV", "Airing Today"]
    
    private var popularArray: [MovieResult] = [MovieResult]()
    private var topRateArray: [MovieResult] = [MovieResult]()
    private var onTVArray: [MovieResult] = [MovieResult]()
    private var airingArray: [MovieResult] = [MovieResult]()
    
    private var genericMovieArray: [MovieResult] = [MovieResult]()
    private var statusForPetition = sections.Popular
    
    //MARK: - Logic
    public func getMovies() {
        GetMovieUseCase.request(section: statusForPetition.description) { [weak self] errorAPI, response in
            guard let self = self else { return }
            
            if let error = errorAPI {
                self.error.value = error
                return
            }
            
            self.genericMovieArray = response?.results ?? []
            self.fillArraysWithMovies()
            self.loginResponse.value = true
        }
    }
    
    public func getSections() -> [String] {
        return sectionsArray
    }
    
    public func setupStatusForPetition(index: Int) {
        switch index {
        case 0:
            statusForPetition = sections.Popular
        case 1:
            statusForPetition = sections.TopRated
        case 2:
            statusForPetition = sections.OnTV
        case 3:
            statusForPetition = sections.AiringToday
        default:
            statusForPetition = sections.Popular
        }
    }
    
    public func verifyIfIsNeededDoRequest() -> Bool {
        switch statusForPetition {
        case .Popular:
            return popularArray.isEmpty
        case .TopRated:
            return topRateArray.isEmpty
        case .OnTV:
            return onTVArray.isEmpty
        case .AiringToday:
            return airingArray.isEmpty
        }
    }
    
    private func fillArraysWithMovies() {
        switch statusForPetition {
        case .Popular:
            popularArray = genericMovieArray
        case .TopRated:
            topRateArray = genericMovieArray
        case .OnTV:
            onTVArray = genericMovieArray
        case .AiringToday:
            airingArray = genericMovieArray
        }
    }
    
    public func getMoviesCount() -> Int {
        switch statusForPetition {
        case .Popular:
            return popularArray.count
        case .TopRated:
            return topRateArray.count
        case .OnTV:
            return onTVArray.count
        case .AiringToday:
            return airingArray.count
        }
    }
    
    public func getMovie(with index: Int) -> MovieResult {
        switch statusForPetition {
        case .Popular:
            return popularArray[index]
        case .TopRated:
            return topRateArray[index]
        case .OnTV:
            return onTVArray[index]
        case .AiringToday:
            return airingArray[index]
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
