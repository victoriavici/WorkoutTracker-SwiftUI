//
//  LogWorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 25/04/2023.
//

import Foundation
class LogWorkoutViewModel: ObservableObject, Identifiable {
    
    @Published var weight = 0.0
    @Published var reps = 0
    @Published var allEx: [Exercise] = [Exercise(name: "cvik"), Exercise(name: "cvik2"), Exercise(name: "cvik3")]
    
    func addSet(index: Int) {
        allEx[index].sets.append(allEx[index].sets.count + 1)
    }
    
}

struct Exercise: Identifiable {
   
    var id: String {
        name
    }
    
    var name: String
    var sets: [Int] = [1, 2]
    
}
