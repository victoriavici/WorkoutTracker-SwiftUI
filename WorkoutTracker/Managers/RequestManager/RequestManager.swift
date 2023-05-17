//
//  RequestManager.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 09/05/2023.
//

//inšpirované https://github.com/GoodRequest/GoodNetworking
 
import GoodRequestManager
import GoodExtensions
import Combine
import Alamofire
import GRCompatible

/**
 Trieda je zodpovedná za správu požiadaviek na server a získavanie údajov cvičení.
 */
class RequestManager: RequestManagerType {
    
    /**
     Funkcia vykoná požiadavku na server na získanie údajov cvičení
     
     Returns:
     - AnyPublisher<ExercisesResponse, Error>
     */
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
    
    /**
     Inicializácia triedy RequestManager s  baseURL
     
     Parameters:
     - baseURL: ApiServer
     */
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
