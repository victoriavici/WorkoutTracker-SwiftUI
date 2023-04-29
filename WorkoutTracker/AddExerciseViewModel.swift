//
//  AddExerciseViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 27/04/2023.
//

import Foundation

class AddExerciseViewModel: ObservableObject, Identifiable {
    
     
    @Published var selectedExercises: [Exercises] = []
    @Published var listOfExercises: [Exercises] = [Exercises(name: "Bench"), Exercises(name: "Squat"), Exercises(name: "Deadlift")] {
        didSet {
            updateExercises()
        }
    }
    @Published var exercises: [Exercises] = []
    @Published var searchText: String = "" {
        didSet {
            updateExercises()
        }
    }
    
    init() {
        updateExercises()
    }
    
    private func updateExercises() {
        let lcExercises = listOfExercises.map({Exercises(name: $0.name.lowercased())})
        
        exercises = searchText == "" ? lcExercises : lcExercises.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    func selectExercise(selected: Exercises) {
        if let index = selectedExercises.firstIndex(where: { $0.id == selected.id }) {
                  selectedExercises.remove(at: index)
              } else {
                  selectedExercises.append(selected)
              }
    }
    
    func createExercise(name: String) {
        listOfExercises.append(Exercises(name: name))
    }
    
}


struct Exercises: Identifiable {
   
    var id: String {
        name
    }
    var name: String
    
}


