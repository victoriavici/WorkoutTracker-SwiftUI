//
//  LogWorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 25/04/2023.
//

import Foundation

class LogWorkoutViewModel: ObservableObject, Identifiable {
    
    @Published var weight = 1
    @Published var reps = 1
    @Published var allEx: [Exercise] = []
    
    func addSet(index: Int) {
        allEx[index].sets.append((allEx[index].sets.count + 1, 0.0, 0))
    }
    
    func deleteSet(exercise: Exercise, index: Int) {
        let exIndex = allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0
        allEx[exIndex].sets.remove(at: index)
        
    }
    
    func addExercise(selected: [Exercises]) {
        selected.forEach { item in
            allEx.append(Exercise(name: item.name))
        }
    }
    
    func removeExercise(exercise: Exercise) {
        if let index = allEx.firstIndex(where: {exercise.id == $0.id}) {
            allEx.remove(at: index)
        }
    }
    
}

struct Exercise: Identifiable {
   
    var id: String {
        name
    }
    var name: String
    var sets: [(set: Int, kg: Double, reps: Int)] = [(1, 0.0, 0), (2, 0.0, 0)]
}



