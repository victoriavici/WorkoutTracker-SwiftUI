//
//  SettingViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import Foundation

/**
 Trieda slúži sledovanie a upozorňovanie na zmeny v hodnotách hmotnosti a vzdialenosti a ukladanie ich do CacheManager
 */
class SettingViewModel: ObservableObject {
    
    @Published var weight : Weight = CacheManager.shared.isWeightInKg ? .kg : .lbs {
        didSet {
            switch weight {
            case .kg:
                CacheManager.shared.isWeightInKg = true
            case .lbs:
                CacheManager.shared.isWeightInKg = false
            }
        }
    }
    @Published var distance : Distance = CacheManager.shared.isDistanceInKm ? .km : .mi {
        didSet {
            switch distance {
            case .km:
                CacheManager.shared.isDistanceInKm = true
            case .mi:
                CacheManager.shared.isDistanceInKm = false
            }
        }
    }
    
}
