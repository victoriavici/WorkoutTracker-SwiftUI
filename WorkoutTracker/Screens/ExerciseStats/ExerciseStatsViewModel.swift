//
//  ExerciseStatsViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import Foundation

class ExerciseStatsViewModel: ObservableObject {
    
    // MARK: - Variables
    
    var workouts = CacheManager.shared.workouts
    var isWeightInKg = CacheManager.shared.isWeightInKg
    
    // MARK: - Logic
    
    /**
     Funkcia vracia cvik z predchádzajúcich workoutov s tým istým menom ako je cvik, pre ktorý sú zobrazované štatistiky,
     
     Parameter:
     - name: String
     
     Returns:
     - [Exercise]
     */
    private func getExercises(name: String) -> [Exercise] {
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
    
    /**
     Funkcia vracia najväčšiu váhu cviku, ktorá bola doposiaľ zaznamenaná.
     
     Parameter:
     - name: String
     
     Returns:
     - String
     */
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
    /**
     Funkcia vracia najlepší set (weight x reps ), ktorý bol doposiaľ zaznamenaný.
     
     Parameter:
     - name: String
     
     Returns:
     - String
     */
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
    
    /**
     Funkcia vracia najlepší session, ktorý bol doposiaľ zaznamenaný.
     
     Parameter:
     - name: String
     
     Returns:
     - String
     */
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
    /**
     Funkcia vracia dáta pre sessions.
     
     Parameter:
     - name: String
     
     Returns:
     - [Double]
     */
    func getSessionData(name: String) -> [Double] {
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
    
    /**
     Funkcia vracia dáta pre najvačšiu váhu.
     
     Parameter:
     - name: String
     
     Returns:
     - [Double]
     */
    func getHeaviestWeightData(name: String) -> [Double] {
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
    
    /**
     Funkcia vracia dáta pre set volume.
     
     Parameter:
     - name: String
     
     Returns:
     - [Double]
     */
    func getBestSetVolumeData(name: String) -> [Double] {
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
    
    /**
     Funkcia vracia dáta pre total reps.
     
     Parameter:
     - name: String
     
     Returns:
     - [Double]
     */
    func getTotalRepsData(name: String) -> [Double] {
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
