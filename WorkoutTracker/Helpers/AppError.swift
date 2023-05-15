//
//  AppError.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 12/05/2023.
//

import Foundation
import Alamofire

/**
 Enum slúži na reprezentáciu chybových stavov alebo chýb, ktoré môžu nastať v aplikácii
 */
enum AppError: Error, Equatable {

    case af(AFError)

    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.af(let lError), .af(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        }
    }

}
