//
//  EndPoint.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 09/05/2023.
//

import GoodRequestManager
import GoodStructs
import Combine
import Alamofire
import Foundation

/**
 Enum reprezentujúci URL adresu servera.
 */
enum ApiServer: String {

    case base = "https://musclewiki.p.rapidapi.com/exercises"

}

/**
 Enum koncových body na serveri
 */
enum Endpoint: GREndpointManager {
    var path: String {
        ""
    }
 
    case exercise

    var method: HTTPMethod { .get }

    var parameters: Either<Parameters, GREncodable>? {
        nil
    }
    
    var headers: HTTPHeaders? {[
        "X-RapidAPI-Key": "e18b883340msh2e5ea91169bccaap1c975ejsnfe2a04425799",
        "X-RapidAPI-Host": "musclewiki.p.rapidapi.com"
    ]}

    var encoding: ParameterEncoding { JSONEncoding.default }
    
    /**
     Vytvorenie URL adresy z daného základného URL a aktuálneho koncového bodu.
     
     Parameters:
     - baseURL: String
     */
    func asURL(baseURL: String) throws -> URL {
        let url = try baseURL.asURL()
        return url
    }
    
    var queryParameters: Parameters? {
          switch self {
          case .exercise:
              return [
                  "name": "name",
                  "category": "category",
                  "muscle": "muscle",
                  "equipment": "equipment",
                  "force": "force",
                  "description": "description",
                  "difficulty": "difficulty"
              ]
          }
      }
}
