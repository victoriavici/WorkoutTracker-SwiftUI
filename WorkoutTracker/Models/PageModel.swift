//
//  PageModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 14/05/2023.
//

import Foundation

/**
 Štruktúra Page nadpis, popis, obrazok a tag
 */
struct Page: Identifiable, Equatable {
    
    var id: String {
        title
    }
    var title: String
    var description: String
    var imageUrl: String
    var tag: Int
    
}

/**
 Pages obsahuje množinu stránok
 */
struct Pages: Equatable {
     let pages: [Page] = [
        .init(title: "Workouts", description: "Start a new workout or browse through your workout history", imageUrl: "workout", tag: 0),
        .init(title: "Log your workout", description: "Track your workout by logging the number of reps and weights for each set of exercises", imageUrl: "logworkout", tag: 1),
        .init(title: "Add exercises", description: "Add exercises to your current workout", imageUrl: "add", tag: 2),
        .init(title: "Create exercise", description: "If you can't find the exercise you are looking for, add it to your list", imageUrl: "create", tag: 3),
        .init(title: "Statistics", description: "Review the statistics of your workout", imageUrl: "stats", tag: 4),
        .init(title: "Exercise stats", description: "Review the statistics and graphs of exercises", imageUrl: "exStats", tag: 5),
        .init(title: "Settings", description: "Set your preffered units of weight and distance", imageUrl: "settings", tag: 6)
     ]
}



