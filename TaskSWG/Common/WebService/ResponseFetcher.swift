//
//  ResponseFetcher.swift


import Foundation

final class ResponseFetcher {
    
    private var dataTask: URLSessionDataTask?
    private let networkingService: NetworkingCall
    
    init(networkingService: NetworkingCall = WebServices()) {
        self.networkingService = networkingService
    }
    
    func fetchRepos(completion: @escaping ((Wheather) -> ())) {
        dataTask?.cancel()
        
        _ = dataTask = networkingService.fetchResponse() { repos in
            completion(repos)
        }
    }
}
