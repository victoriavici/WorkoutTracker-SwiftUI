//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 25/04/2023.
//

import Foundation
import RealmSwift

class Workout: Object, Identifiable {
 
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var start: Date
    @Persisted var end: Date
    @Persisted var name: String
    @Persisted var exercises = List<ExerciseSet>()
    
}
