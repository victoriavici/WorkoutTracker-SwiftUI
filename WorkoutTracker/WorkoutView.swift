//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
import os

struct WorkoutView: View {
    
    @ObservedObject var viewModel = WorkoutViewModel()
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack() {
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
                    .padding(.vertical)
                    
                    Text("History (\(viewModel.workouts.count))")
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .font(.headline)
                        .padding(.horizontal)
                    
                }
                ScrollView{
                    LazyVStack() {
                        ForEach (viewModel.workouts) { workout in
                            historyLog(workout: workout)
                                .padding(.vertical,8 )
                        }
                    }
                    
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
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
    
    func historyLog(workout: Workout) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text(viewModel.formatter(date: workout.startTime)).font(.caption)
                Text(viewModel.getName(workout: workout)).bold()
            }
            HStack(alignment: .center, spacing: 32) {
                VStack {
                    Text("Time")
                    Text(viewModel.getTime(workout: workout))
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Volume")
                    Text(String(format: "%.2f", viewModel.countVolume(workout: workout)))
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Sets")
                    Text(String(viewModel.countSets(workout: workout)))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 24)
        }
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
    
}
