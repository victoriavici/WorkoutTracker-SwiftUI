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
    @Published var endTime = Date()
    @Published var sets: Int = 0
    @Published var volume: Double = 0.0
    @Published var allEx: [Exercise] = [] {
        didSet{
            countSets()
            countVolume()
        }
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

    private func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
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
                volume += Double(sets.reps) * sets.kg
            }
        }
    }
    
    func addSet(index: Int) {
        allEx[index].sets.append((allEx[index].sets.count + 1, 0.0, 0))
    }
    
    func deleteSet(exercise: Exercise, index: IndexSet) {
        let exIndex = allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0
        allEx[exIndex].sets.remove(atOffsets: index)
        
        let newSets = allEx[exIndex].sets.enumerated().map { index, tuple in
            return (index + 1, tuple.kg, tuple.reps)
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
    
}

struct Exercise: Identifiable {
   
    var id: String {
        name
    }
    var name: String
    var sets: [(set: Int, kg: Double, reps: Int)] = [(1, 0.0, 0), (2, 0.0, 0)]
    
}



