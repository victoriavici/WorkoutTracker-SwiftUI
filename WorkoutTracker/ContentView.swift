//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Sebastian Mraz on 18/04/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: WorkoutTrackerDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(WorkoutTrackerDocument()))
    }
}
