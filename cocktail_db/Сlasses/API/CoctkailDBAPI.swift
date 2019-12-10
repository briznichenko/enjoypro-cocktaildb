//
//  CoctkailDBAPI.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

let cocktailDBProvider = MoyaProvider<CocktailDB>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

public enum CocktailDB {
    case categories
    case cocktails(String)
}

extension CocktailDB: TargetType {
    public var baseURL: URL { return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")! }
    
    public var path: String {
        switch self {
        case .categories:
            return "/list.php"

        case .cocktails(_):
            return "/filter.php"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .categories:
            return .requestParameters(parameters: ["c": "list"], encoding: URLEncoding.default)
        case .cocktails(let name):
            return .requestParameters(parameters: ["c": name], encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
