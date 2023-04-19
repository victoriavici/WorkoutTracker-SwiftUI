//
//  SettingViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    @Published var weight : Weight = .kg
    @Published var distance : Distance = .km
    
}
