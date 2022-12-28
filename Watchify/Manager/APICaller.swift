//
//  APICaller.swift
//  Watchify
//
//  Created by User on 09/12/22.
//

import Foundation

struct Constants {
    static let API_KEY = "4e8ce2b39e1fea65f9b40748809cf1a1"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_KEY = "AIzaSyBe6HMiujVpROVLtCPEhImAMm6pdqD-aKk"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search"
}

enum APIError: Error{
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMoives(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping(Result<[Title],Error>)->Void){
        
        //Smj ni aaya
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovies(with query: String, completion: @escaping(Result<VideoElement,Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)?q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
//                let results = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
//                print(results)
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self,from: data)
                completion(.success(results.items[0]))
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
}


