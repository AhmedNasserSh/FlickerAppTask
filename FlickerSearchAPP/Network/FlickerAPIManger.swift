//
//  FlickerAPIManger.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/17/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
let moyaProvider = MoyaProvider<FlickerAPIManger>()
enum FlickerAPIManger {
    case getImages(query:String,page:Int)
    case getGroups(query: String)
}
extension FlickerAPIManger: TargetType {
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
    // set the base url and paths for each endpoints
    var baseURL : URL { return URL(string: APIConstant.baseURL)!}
    var path: String { return "" }
    // define the method use
    var method: Moya.Method {
        return .get
    }
    // parameters if needed
    var parameters: [String: Any]? {
        return FlickerRequestWrapper.getBody(service: self)
    }
    // encoding parameter in json or default
    var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}
public func url(route: TargetType) -> String {
    let url = route.baseURL.appendingPathComponent(route.path).absoluteString
    return url
}
