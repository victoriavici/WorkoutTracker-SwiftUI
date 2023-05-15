//
//  CreateExerciseViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 29/04/2023.
//

import Foundation

/**
 ViewModel pre CreateExerciseView obsahujúci nazov
 */
class CreateExerciseViewModel: ObservableObject {
    
    @Published var name: String = ""
    
}
