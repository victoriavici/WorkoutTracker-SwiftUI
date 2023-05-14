//
//  RequestManagerType.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 09/05/2023.
//

import Combine
import Alamofire
import GoodRequestManager

protocol RequestManagerType: AnyObject {
    
    func fetchData() -> AnyPublisher<ExercisesResponse, Error>

}

struct ExercisesResponse: GRDecodable {
    
    var data: [Exercises]
    
    enum CodingKeys: String, CodingKey {
        case data = "items"
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var data = [Exercises]()
        while !container.isAtEnd {
            data.append(try container.decode(Exercises.self))
        }
        self.data = data
    }
    
}

