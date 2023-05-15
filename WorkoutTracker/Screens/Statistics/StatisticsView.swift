//
//  StatisticsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
/**
 Screena poskytuje štatistiky o workoutoch a hlavné cviky
 */
struct StatisticsView: View {
    
    @ObservedObject var viewModel = StatisticsViewModel()
    /**
     Zobrazenie štatistík a hlavných cvikoch
     */
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                
                statsRow(text: "Workouts", result: String(viewModel.workouts.count))
                statsRow(text: "Total volume", result: viewModel.getTotalVolumeString())
                statsRow(text: "Avg. workouts volume", result: viewModel.getAvgVolume())
                statsRow(text: "Avg. workouts duration", result: viewModel.getAvgDuration())

                Spacer()
                Text("Main exercises")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                List() {
                    ForEach(viewModel.getMainExercises(), id: \.0) { exercise in
                        exerciseLog(exercise: exercise)
                    }
                }
                .listStyle(.plain)
                
            }
            .padding()
            .navigationBarTitle("Statistics", displayMode: .inline)
        }
    }
    
}

// MARK: - Components

private extension StatisticsView {
    /**
     Funcia zobrazuje názov štatistiky spolu s výsledkom
     
     Parameters:
     - text: String, result: String
     
     Returns:
     - some View
     */
    func statsRow(text: String, result: String) -> some View {
        HStack {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(result)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    /**
     Funkcia slúži na zobrazenie cviku s počtom, koľkokŕat bol odcvičený
     
     Parameters:
     - exercise: (name: String, count: Int)
     
     Returns:
     - some View
     */
    func exerciseLog(exercise: (name: String, count: Int)) -> some View {
        VStack {
            NavigationLink(destination: ExerciseStatsView(name: exercise.name)) {
                VStack (alignment: .leading) {
                    Text(exercise.name)
                        .font(.subheadline)
                        .bold()
                    Text(exercise.count > 1 ? "\(exercise.count) times" : "1 time" )
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
}


struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
    
}
