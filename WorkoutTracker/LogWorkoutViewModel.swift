//
//  LogWorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 25/04/2023.
//

import Foundation
import Combine

class LogWorkoutViewModel: ObservableObject, Identifiable {
    
    @Published var inWorkout = false
    var timer: AnyCancellable?
    @Published var time: String = "00:00:00"
    @Published var startTime: Date = Date()
    @Published var currentTime: Date = Date()
    @Published var sets: Int = 0
    @Published var volume: Double = 0.0
    @Published var allEx: [Exercise] = [] {
        didSet{
            countSets()
            countVolume()
        }
    }
    @Published var isWeightInKg = CacheManager.shared.isWeightInKg
    
    init() {
        subscribe()
    }
    
    func subscribe() {
        CacheManager.shared.isWeightInKgPublisher
            .assign(to: &$isWeightInKg)
    }
    
    func setInWorkout() {
        inWorkout.toggle()
    }
    
    func setStartTime() {
        startTime = Date()
    }
    
    func stopTimer() {
        timer?.cancel()
    }
    
    func updateTime() {
        currentTime = Date()
        time = timeToString(interval: currentTime.timeIntervalSince(startTime))
    }
    
    private func countSets() {
        sets = 0
        self.allEx.forEach { exercise in
            self.sets += exercise.sets.count
        }
    }
    
    private func countVolume() {
        volume = 0.0
        self.allEx.forEach { exercise in
            exercise.sets.forEach { sets in
                volume += Double(sets.reps) * sets.weight
            }
        }
    }
    
    func addSet(index: Int) {
        let newSet = Exercise.Set(set: (allEx[index].sets.count + 1), weight: 0.0, reps: 0)
        allEx[index].sets.append(newSet)
    }
    
    func deleteSet(exercise: Exercise, index: IndexSet) {
        let exIndex = allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0
        allEx[exIndex].sets.remove(atOffsets: index)
        
        let newSets = allEx[exIndex].sets.enumerated().map { index, tuple in
            return Exercise.Set(set: index + 1, weight: tuple.weight, reps: tuple.reps)
        }
        allEx[exIndex].sets = newSets
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
    
    func clearWorkout() {
        allEx.removeAll()
    }
    
    func saveWorkout() {
        if !CacheManager.shared.isWeightInKg {
            for i in 0..<allEx.count {
                var exercise = allEx[i]
                for j in 0..<exercise.sets.count {
                    var set = exercise.sets[j]
                    if set.weight > 0 {
                        set.weight /= C.kgToLbsMultiplayer
                    }
                    exercise.sets[j] = set
                }
                allEx[i] = exercise
            }
        }
        CacheManager.shared.add(workout: Workout(startTime: startTime,endTime: Date(), allEx: allEx))
    }
    
    func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

enum Status: String {
    
    case loading = "Loading..."
    case error = "Error"
    case success = "Success"
}


