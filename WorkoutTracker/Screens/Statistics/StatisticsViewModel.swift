//
//  StatisticsViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import Foundation
import SwiftUICharts

/**
 ViewModel k StatisticsView
 */
class StatisticsViewModel: ObservableObject {
    
    @Published var workouts = CacheManager.shared.workouts
    @Published var isWeightInKg = CacheManager.shared.isWeightInKg
    
    // MARK: - Logic
    /**
     Inicializácia
    */
    init() {
        subscribe()
    }
    
    /**
     Funkcia slúži na nastavenie publisherov pre sledovanie zmien v dátach o tréningu a nastaveniach jednotiek hmotnosti
     */
    func subscribe() {
        CacheManager.shared.workoutsPublisher
            .assign(to: &$workouts)
        CacheManager.shared.isWeightInKgPublisher
            .assign(to: &$isWeightInKg)
    }
    /**
     Funckia slúži na výpočet celkového volume tréningov
     
     Returns:
     - Double
     */
    private func getTotalVolume() -> Double {
        var volume = 0.0
        workouts.forEach() { workout in
            workout.allEx.forEach() { exercise in
                exercise.sets.forEach() { set in
                    volume += Double(set.reps) * set.weight
                }
            }
        }
        return isWeightInKg ? volume : volume * C.kgToLbsMultiplayer
    }
    
    /**
     Funckia slúži na formátovanie celkového volume tréningov
     
     Returns:
     - String
     */
    func getTotalVolumeString() -> String {
        String(format: "%.2f", getTotalVolume()) + (isWeightInKg ? "kg" : "lbs")
    }
    
    /**
     Funckia slúži na formátovanie priemerného volume tréningu
     
     Returns:
     - String
     */
    func getAvgVolume() -> String {
        String(format: "%.2f", getTotalVolume()/Double(workouts.count)) + (isWeightInKg ? "kg" : "lbs")
    }
    
    /**
     Funckia slúži na získanie priemerného času tréningov
     
     Returns:
     - String
     */
    func getAvgDuration() -> String {
        var duration = 0.0
        workouts.forEach() { workout in
            duration += workout.endTime!.timeIntervalSince(workout.startTime)
        }
        return timeToString(interval: duration/Double(workouts.count))
    }
    
    /**
     Funckia slúži na získanie hlavných cvikov spolu s počtom ich vykonania vo workoutoch
     
     Returns:
     - [(String, Int)]
     */
    func getMainExercises() -> [(String, Int)] {
        var exercises: [(name: String, count: Int)] = []
        workouts.forEach() { workout in
            workout.allEx.forEach() { exercise in
                if let index = exercises.firstIndex(where: { (name: String, count: Int) in
                    exercise.name == name
                }) {
                    exercises[index].count += 1
                } else {
                    exercises.append((exercise.name, 1))
                }
            }
        }
        exercises.sort { $0.count > $1.count }
        return exercises
    }

    /**
     Funkcia na prevod čísla do stringu dátumu
     
     Parameters:
     - interval: Double
     
     Retuns:
     - String
     */
    private func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
