//
//  RequestManager.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 09/05/2023.
//

import GoodRequestManager
import GoodExtensions
import Combine
import Alamofire

class RequestManager: RequestManagerType {
    func fetchData() -> AnyPublisher<ExercisesResponse, Error> {
        let endpoint = Endpoint.exercise
        return session.request(endpoint: endpoint)
            .gr.goodify()
            .mapError { AppError.af($0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Constants
    
    internal let session: GRSession<Endpoint, ApiServer>
    
    // MARK: - Initialization
    
    init(baseURL: ApiServer) {
        session = GRSession(
            baseURL: baseURL,
            configuration: .default
        )
    }
}

enum AppError: Error, Equatable {

    case af(AFError)

    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.af(let lError), .af(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        }
    }

}
    
