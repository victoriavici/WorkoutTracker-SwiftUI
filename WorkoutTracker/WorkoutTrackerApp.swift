//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 18/04/2023.
//

import SwiftUI

@main
struct WorkoutTrackerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: WorkoutTrackerDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
