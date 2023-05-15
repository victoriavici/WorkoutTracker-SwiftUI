//
//  LogWorkoutViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 25/04/2023.
//

import Foundation
import Combine

/**
 ViewModel pre LogWorkoutView
 */
class LogWorkoutViewModel: ObservableObject, Identifiable {
    
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
            CacheManager.shared.currentWorkout = Workout(startTime: startTime, endTime: nil , allEx: allEx)
        }
    }
    @Published var isWeightInKg = CacheManager.shared.isWeightInKg
    @Published var workouts = CacheManager.shared.workouts
    @Published var previousExercises: [Exercise] = []
    
    // MARK: - Logic
    
    /**
     Inicializácia
     */
    init() {
        subscribe()
        if let start = CacheManager.shared.currentWorkout?.startTime {
            startTime = start
        }
    }
    
    /**
     Funkcia slúži na nastavenie publisherov pre sledovanie zmien v dátach o tréningu a nastaveniach jednotiek hmotnosti
     */
    func subscribe() {
        CacheManager.shared.isWeightInKgPublisher
            .assign(to: &$isWeightInKg)
        CacheManager.shared.workoutsPublisher
            .assign(to: &$workouts)
    }

    /**
     Nastavenie začiatočného času
     */
    func setStartTime() {
        startTime = Date()
    }
    
    /**
     Ukončenie timeru
     */
    func stopTimer() {
        timer?.cancel()
    }
    
    /**
     Aktualizovanie času trvania workoutu
     */
    func updateTime() {
        currentTime = Date()
        time = timeToString(interval: currentTime.timeIntervalSince(startTime))
    }
    
    /**
     Funkcia spočíta počet aktuálnych setov
     */
    private func countSets() {
        sets = 0
        self.allEx.forEach { exercise in
            self.sets += exercise.sets.count
        }
    }
    
    /**
     Funkcia spočíta  aktuálny volume tréningu
     */
    private func countVolume() {
        volume = 0.0
        self.allEx.forEach { exercise in
            exercise.sets.forEach { sets in
                volume += Double(sets.reps) * sets.weight
            }
        }
    }
    
    /**
     Pridanie setu ku cviku
     
     Parameters:
     - index: Int
     */
    func addSet(index: Int) {
        let newSet = Exercise.Set(set: (allEx[index].sets.count + 1), weight: 0.0, reps: 0)
        allEx[index].sets.append(newSet)
    }
    
    /**
     Odstránenie setu z cviku
     
     Parameters:
     - exercise: Exercise, index: IndexSet
     */
    func deleteSet(exercise: Exercise, index: IndexSet) {
        let exIndex = allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0
        allEx[exIndex].sets.remove(atOffsets: index)
        
        let newSets = allEx[exIndex].sets.enumerated().map { index, tuple in
            return Exercise.Set(set: index + 1, weight: tuple.weight, reps: tuple.reps)
        }
        allEx[exIndex].sets = newSets
    }
    
    /**
     Pridanie cviku do workoutu
     
     Parameters:
     - selected: [Exercises]
     */
    func addExercise(selected: [Exercises]) {
        selected.forEach { item in
            allEx.append(Exercise(name: item.name))
            getPrevious(name: item.name)
        }
    }
    
    /**
     Odstránenie cviku z workoutu
     
     Parameters:
     - exercise: Exercise
     */
    func removeExercise(exercise: Exercise) {
        if let index = allEx.firstIndex(where: {exercise.id == $0.id}) {
            allEx.remove(at: index)
        }
    }
    
    /**
        Vymazanie cvikov workoutu
     */
    func clearWorkout() {
        allEx.removeAll()
    }
    
    /**
     Funkcia na uloženie workoutu do userdefaults
     */
    func saveWorkout() {
        if !isWeightInKg {
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
    
    /**
     Funkcia na prevod čísla do stringu dátumu
     
     Parameters:
     - interval: Double
     
     Retuns:
     - String
     */
    func timeToString(interval: Double) -> String {
        let hours = Int(interval / 3600)
        let minutes = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    /**
     Funkcia na získanie predchádzajúcich výkonov
     
     Parameters:
     - name: String
     */
    func getPrevious(name: String) {
        for workout in workouts {
            for exercise in workout.allEx {
                if exercise.name == name {
                    previousExercises.append(exercise)
                    return
                }
            }
        }
    }
    
    /**
     Nastavenie atribútov pri pokračovaní vo workoute
     */
    func resumeWorkout() {
        allEx = CacheManager.shared.currentWorkout!.allEx
        startTime = CacheManager.shared.currentWorkout!.startTime
    }

}


