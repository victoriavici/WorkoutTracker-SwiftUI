//
//  CacheManager.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 01/05/2023.
//

import Foundation
import GoodPersistence
import Combine

/**
 Trieda slúži na uchovávanie a správu rôznych údajov v aplikácii.
 */
class CacheManager {
    
    static let shared: CacheManager = .init()
    
    @UserDefaultValue("isWeightInKg", defaultValue: true)
    var isWeightInKg: Bool

    lazy var isWeightInKgPublisher: AnyPublisher<Bool, Never> = self._isWeightInKg.publisher.eraseToAnyPublisher()
    
    @UserDefaultValue("isDistanceInKm", defaultValue: true)
    var isDistanceInKm: Bool

    lazy var isDistanceInKmPublisher: AnyPublisher<Bool, Never> = self._isDistanceInKm.publisher.eraseToAnyPublisher()
    
    @UserDefaultValue("workouts", defaultValue: [])
    var workouts: [Workout]

    lazy var workoutsPublisher: AnyPublisher<[Workout], Never> = self._workouts.publisher.eraseToAnyPublisher()
    
    func add(workout: Workout) {
        workouts.append(workout)
    }
    
    @UserDefaultValue("userExercises", defaultValue: [])
    var userExercises: [Exercises]

    lazy var userExercisesPublisher: AnyPublisher<[Exercises], Never> = self._userExercises.publisher.eraseToAnyPublisher()
    
    func add(exercise: Exercises) {
        userExercises.append(exercise)
    }
    
    private var currentWorkoutSubject = CurrentValueSubject<Workout?, Never>(nil)

       var currentWorkout: Workout? {
           get { currentWorkoutSubject.value }
           set { currentWorkoutSubject.send(newValue) }
       }

    var currentWorkoutPublisher: AnyPublisher<Workout?, Never> {
        currentWorkoutSubject.eraseToAnyPublisher()
    }
}
