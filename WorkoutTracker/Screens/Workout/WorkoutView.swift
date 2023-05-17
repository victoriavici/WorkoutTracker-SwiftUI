//
//  WorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
import os

/**
 Screena slúži na zobrazenie histórie a spustenie workoutu
 */
struct WorkoutView: View {
    
    @ObservedObject var viewModel = WorkoutViewModel()
 
    // MARK: - Body
    
    /**
     Zobrazenie všetkých vytvorených workoutov a buttonu na začatie workoutu.
     */
    var body: some View {
        
        NavigationView {
            VStack {
                VStack() {
                    NavigationLink(destination: NavigationLazyView(LogWorkoutView(viewModel: LogWorkoutViewModel()))) {
                        Text(viewModel.inWorkout == nil ? "Start an empty workout" : "Resume workout")
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
                List {
                    ForEach (viewModel.workouts.reversed()) { workout in
                        historyLog(workout: workout)
                            .padding(.vertical, 8)
                            .padding(.bottom, workout == viewModel.workouts.first ? 48 : 0)
                    }
                    .listSectionSeparator(.hidden, edges: .bottom)

                }
                .listStyle(.plain)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Workout", displayMode: .inline)
            .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .top)
        }
    }
}



// MARK: - Components

private extension WorkoutView {
    /**
     Funkcia na zobrazenie info o cviku
     
     Parameters:
     - workout: Workout
     
     Returns:
     - some View
     */
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
