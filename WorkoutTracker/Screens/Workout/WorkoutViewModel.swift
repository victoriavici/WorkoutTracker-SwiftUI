//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 01/05/2023.
//

import Foundation
/**
 ViewModel pre WokroutView
 */
class WorkoutViewModel: ObservableObject, Identifiable {
    @Published var workouts = CacheManager.shared.workouts
    @Published var isWeightInKg = CacheManager.shared.isWeightInKg
    @Published var inWorkout = CacheManager.shared.currentWorkout 
    
    /**
     Inicializácia
     */
    init() {
        subscribe()
    }
    
    /**
     Funkcia slúži na nastavenie publisherov pre sledovanie zmien
     */
    func subscribe() {
        CacheManager.shared.workoutsPublisher
            .assign(to: &$workouts)
        CacheManager.shared.isWeightInKgPublisher
            .assign(to: &$isWeightInKg)
        CacheManager.shared.currentWorkoutPublisher
            .assign(to: &$inWorkout)
    }
    
    /**
     Funkcia vracia dátum vykonania workoutu
     
      Parameters:
      - workout: Workout
      Returns:
      - String
     */
    func getTime(workout: Workout) -> String {
        return workout.timeToString(interval: workout.endTime!.timeIntervalSince(workout.startTime))
    }
    
    /**
     Formátovanie datúmu
     Parameters:
     - date: Date
     Returns:
     - String
     */
    func formatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    /**
     Funkcia vracia sety workoutu
     
     Parameters:
     - workout: Workout
     Returns:
     - Int
     */
    func countSets(workout: Workout) -> Int {
        var sets = 0
        workout.allEx.forEach { exercise in
            sets += exercise.sets.count
        }
        return sets
    }
    
    /**
     Funkcia vracia volume workoutu
     
     Parameters:
     - workout: Workout
     Returns:
     - Double
     */
    func countVolume(workout: Workout) -> Double {
        var volume = 0.0
        workout.allEx.forEach { exercise in
            exercise.sets.forEach { sets in
                volume += Double(sets.reps) * sets.weight
            }
        }
        if !isWeightInKg {
            volume = volume * C.kgToLbsMultiplayer
        }
        return volume
    }
    
    /**
     Funkcia vracia názov wokroutu na základe času začatia
     
     Parameters:
     - workout: Workout
     Returns:
     - String
     */
    func getName(workout: Workout) -> String {
        let hour = Calendar.current.component(.hour, from: workout.startTime)
        switch hour {
        case 6..<11:
            return "Morning Training"
        case 11..<13:
            return "Lunch Training"
        case 13..<18:
            return "Afternoon Training"
        case 18..<21:
            return "Evening Training"
        case 21..<24:
            return "Night Training"
        case 0..<6:
            return "Night Training"
        default:
            return "Training"
        }
    }
    
}
