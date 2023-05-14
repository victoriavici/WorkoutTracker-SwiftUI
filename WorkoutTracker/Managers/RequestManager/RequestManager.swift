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
import GRCompatible

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
        GRSessionConfiguration.logLevel = .none
        
        session = GRSession(
            baseURL: baseURL,
            configuration: GRSessionConfiguration(
                urlSessionConfiguration: .ephemeral,
                interceptor: nil,
                serverTrustManager: nil,
                eventMonitors: [GRSessionLogger()]
            )
        )
    }
    
}
