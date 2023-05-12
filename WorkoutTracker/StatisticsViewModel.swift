//
//  StatisticsViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import Foundation
import SwiftUICharts


class StatisticsViewModel: ObservableObject {
    
    @Published var workouts = CacheManager.shared.workouts
    
    init() {
        subscribe()
    }
    
    func subscribe() {
        CacheManager.shared.workoutsPublisher
            .assign(to: &$workouts)
    }
    
    func getTotalVolume() -> Double {
        var volume = 0.0
        workouts.forEach() { workout in
            workout.allEx.forEach() { exercise in
                exercise.sets.forEach() { set in
                    volume += Double(set.reps) * set.weight
                }
            }
        }
        return volume
    }
    
    func getAvgVolume() -> String {
        String(format: "%.2f", getTotalVolume()/Double(workouts.count))
    }
    
    func getAvgDuration() -> String{
        var duration = 0.0
        workouts.forEach() { workout in
            duration += workout.endTime.timeIntervalSince(workout.startTime)
        }
        return timeToString(interval: duration)
    }
    
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

    private func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
