//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
import os

struct WorkoutView: View {
    
    // MARK: - Body

    var body: some View {
        
        NavigationView {
            VStack {
                VStack(spacing: 10) {
                    Text("Quick Start")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    
                    NavigationLink(destination: LogWorkoutView()) {
                        Text("Start an empty workout")
                            .frame(maxWidth: .infinity, maxHeight: 20)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(3)
                    }
                    .padding(.horizontal, 20)
                    
                    
                    Text("History")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding()
                    
                }
                List(0..<10) { item in
                    historyLog()
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Workout", displayMode: .inline)
            .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .top)
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) { Image(systemName: "gearshape")
                })
            .background(Color("pozadie"))
        }
    }
    
}

// MARK: - Components

private extension WorkoutView {
  
    func historyLog() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("DateTime").font(.subheadline)
            Text("Name")
            
            HStack(alignment: .center,spacing: 52) {
                    VStack {
                        Text("Time")
                        Text("xxxx")
                    }
                    VStack {
                        Text("Volume")
                        Text("xxxx")
                    }
                    VStack {
                        Text("Sets")
                        Text("xxxx")
                    }
                }
            .padding(.horizontal, 55)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
