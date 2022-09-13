//
//  WebServiceConstants.swift

import UIKit

struct WebServicesConstant {
    
    static let baseUrlwithKey = "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502"
    static let WhetherForeCastApi = "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502&q=\(common.sharedInstance.sharedlocation)&days=7&aqi=no&alerts=no"
    
}
// Status Code

enum StatusCode : Int {
    
    case notreachable = 0
    case success = 200
    case multipleResponse = 300
    case unAuthorized = 401
    case notFound = 404
    case ServerError = 500
    
}
