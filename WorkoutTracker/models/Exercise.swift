//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 25/04/2023.
//

import Foundation
import RealmSwift

class Exercisee: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
}
