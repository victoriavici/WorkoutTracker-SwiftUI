//
//  ExerciseStatsViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import Foundation

class ExerciseStatsViewModel: ObservableObject {
    
    var workouts = CacheManager.shared.workouts
    var isWeightInKg = CacheManager.shared.isWeightInKg
    
    func getExercises(name: String) -> [Exercise] {
        var exercises: [Exercise] = []
        workouts.forEach() { workout in
            workout.allEx.forEach() { exercise in
                if exercise.name == name {
                    exercises.append(exercise)
                }
            }
        }
        return exercises
    }
    
    func getHeviestWeight(name: String) -> String {
        var maxWeight = 0.0
        getExercises(name: name).forEach() { exercise in
            exercise.sets.forEach() { set in
                if (set.weight > maxWeight) {
                    maxWeight = set.weight
                }
            }
        }
        return String(format: "%.2f", isWeightInKg ? maxWeight : maxWeight * C.kgToLbsMultiplayer) + (isWeightInKg ? "kg" : "lbs")

    }
    
    func getBestSet(name: String) -> String {
        var maxWeight = 0.0
        var maxReps = 0
        getExercises(name: name).forEach() { exercise in
            exercise.sets.forEach() { set in
                if (set.weight * Double(set.reps) > maxWeight * Double(maxReps)) {
                    maxWeight = set.weight
                    maxReps = set.reps
                }
            }
        }
        return String(format: "%.2f", isWeightInKg ? maxWeight : maxWeight * C.kgToLbsMultiplayer) + (isWeightInKg ? "kg" : "lbs") + " x \(maxReps)"

    }
    
    func getBestSession(name: String) -> String {
        var maxWeight = 0.0
        getExercises(name: name).forEach() { exercise in
            var weight = 0.0
            exercise.sets.forEach() { set in
                weight += set.weight * Double(set.reps)
            }
            if (weight > maxWeight) {
                maxWeight = weight
            }
        }
        return String(format: "%.2f%@", isWeightInKg ? maxWeight : maxWeight * C.kgToLbsMultiplayer, isWeightInKg ? "kg" : "lbs")

    }
    
    func getSessionData(name: String) -> [Double]{
        var data: [Double] = []
        getExercises(name: name).forEach() { exercise in
            var weight = 0.0
            exercise.sets.forEach() { set in
                weight += set.weight * Double(set.reps)
            }
            data.append(isWeightInKg ? weight : weight * C.kgToLbsMultiplayer)
        }
        return data
    }
    
    func getHeaviestWeightData(name: String) -> [Double]{
        var data: [Double] = []
        getExercises(name: name).forEach() { exercise in
            var weight = 0.0
            exercise.sets.forEach() { set in
                if set.weight > weight {
                    weight = set.weight
                }
            }
            data.append(isWeightInKg ? weight : weight * C.kgToLbsMultiplayer)
        }
        return data
    }
    
    func getBestSetVolumeData(name: String) -> [Double]{
        var data: [Double] = []
        getExercises(name: name).forEach() { exercise in
            var weight = 0.0
            exercise.sets.forEach() { set in
                if (set.weight * Double(set.reps)) > weight {
                    weight = set.weight * Double(set.reps)
                }
            }
            data.append(isWeightInKg ? weight : weight * C.kgToLbsMultiplayer)
        }
        return data
    }
    
    func getTotalRepsData(name: String) -> [Double]{
        var data: [Double] = []
        getExercises(name: name).forEach() { exercise in
            var reps = 0
            exercise.sets.forEach() { set in
                reps += set.reps
            }
            data.append(Double(reps))
        }
        return data
    }
   
}
