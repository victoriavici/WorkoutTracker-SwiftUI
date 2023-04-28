//
//  AddExerciseViewModel.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 27/04/2023.
//

import Foundation

class AddExerciseViewModel: ObservableObject, Identifiable {
    
    @Published var selectedExercises: [Exercises] = []
    @Published var exercises: [Exercises] = [Exercises(name: "Bench"), Exercises(name: "Squat"), Exercises(name: "Deadlift")]

    
    func selectExercise(selected: Exercises) {
        if let index = selectedExercises.firstIndex(where: { $0.id == selected.id }) {
                  selectedExercises.remove(at: index)
              } else {
                  selectedExercises.append(selected)
              }
    }
    
    func addToWorkout() {
        
    }
}


struct Exercises: Identifiable {
   
    var id: String {
        name
    }
    var name: String
}


