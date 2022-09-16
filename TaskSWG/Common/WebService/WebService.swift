//
//  WebService.swift
//


import Foundation

protocol NetworkingCall {
    
    @discardableResult func fetchResponse(completion: @escaping (Wheather) -> ()) -> URLSessionDataTask
    
}

//MARK: - ResponseHandling

final class WebServices : NetworkingCall {
    
    private let session = URLSession.shared
    
    func fetchResponse(completion: @escaping (Wheather) -> ()) -> URLSessionDataTask {
        if let urlString = URL(string: WebServicesConstant.WhetherForeCastApi) {
            let request = URLRequest(url:urlString)
            let task = session.dataTask(with: request) { (data, response, error) in
                
                guard let result = data,
                      let finalresponse = try? JSONDecoder().decode(Wheather.self, from: result) else {
                    
                    if let error = error as NSError?
                    {
                        switch error.code {
                        case NSURLErrorNotConnectedToInternet:
                            print("Internet not connected")
                        case StatusCode.notFound.rawValue :
                            print("Not Found")
                        case StatusCode.unAuthorized.rawValue :
                            print("UnAuthourized")
                        case StatusCode.ServerError.rawValue :
                            print("Server Error")
                        default:
                            print("Not Reachable")
                        }
                    }
                    return
                }
                
                completion(finalresponse)
                
            }
            
            task.resume()
            return task
        }
        return URLSessionDataTask()
    }
}
