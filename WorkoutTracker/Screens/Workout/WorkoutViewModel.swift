//
//  WorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 01/05/2023.
//

import Foundation

class WorkoutViewModel: ObservableObject, Identifiable {
    @Published var workouts = CacheManager.shared.workouts
    @Published var isWeightInKg = CacheManager.shared.isWeightInKg
    
    init() {
        subscribe()
    }
    
    func subscribe() {
        CacheManager.shared.workoutsPublisher
            .assign(to: &$workouts)
        CacheManager.shared.isWeightInKgPublisher
            .assign(to: &$isWeightInKg)
    }
    
    func getTime(workout: Workout) -> String {
        return workout.timeToString(interval: workout.endTime.timeIntervalSince(workout.startTime))
    }
    
    func formatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func countSets(workout: Workout) -> Int {
        var sets = 0
        workout.allEx.forEach { exercise in
            sets += exercise.sets.count
        }
        return sets
    }
    
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
