//
//  AppError.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 12/05/2023.
//

import Foundation
import Alamofire

enum AppError: Error, Equatable {

    case af(AFError)

    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.af(let lError), .af(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        }
    }

}
