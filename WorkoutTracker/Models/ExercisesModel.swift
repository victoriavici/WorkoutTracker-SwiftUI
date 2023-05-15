//
//  ExercisesModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 12/05/2023.
//

import Foundation

/**
Struktura Exercises obsahuje názov cviku
*/
struct Exercises: Codable, Equatable, Identifiable {
    
    var id: String {
        name
    }
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "exercise_name"
    }
    
}

/**
 Exercise obsahuje meno a sety.
 Struktura sets pozostáva z čísla setu, počtu opakovaní a kíl
 */
struct Exercise: Codable, Equatable, Identifiable {
    
    var id: String {
        name
    }
    var name: String
    var sets: [Set] = [Set(set: 1, weight: 0.0, reps: 0), Set(set: 2, weight: 0.0, reps: 0)]
    
    init(name: String) {
        self.name = name
        self.sets = [Set(set: 1, weight: 0.0, reps: 0), Set(set: 2, weight: 0.0, reps: 0)]
    }
    
    struct Set: Codable, Equatable {
        
        let set: Int
        var weight: Double
        var reps: Int
        
    }
    
}

/**
 Workout obsahuje začiatočný čas, konečný čas a cviky, ktoré boli vykonané počas workoutu.
 */
struct Workout: Codable, Identifiable, Equatable {
    
    var id: Date {
        startTime
    }
    var startTime: Date = Date()
    var allEx: [Exercise] = []
    var endTime: Date? = nil
    
    init(startTime: Date, endTime: Date?, allEx: [Exercise]) {
        self.startTime = startTime
        self.allEx = allEx
        self.endTime = endTime
    }
    /**
     Funcia slúži na získanie dátumu vo forme stringu
     
     Parameters:
     - interval: Double
     
     Returns:
     - String
     */
    func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}
