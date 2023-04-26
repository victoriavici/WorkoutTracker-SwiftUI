//
//  ExerciseSet.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 25/04/2023.
//

import Foundation
import RealmSwift

class ExerciseSet: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var exercise: Exercisee
    @Persisted var weight: List<Float>
    @Persisted var reps: List<Int>
    
}
