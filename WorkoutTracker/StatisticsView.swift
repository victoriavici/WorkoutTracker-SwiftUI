//
//  StatisticsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel = StatisticsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                HStack {
                    Text("Workouts")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(viewModel.workouts.count))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Total volume")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(String(viewModel.getTotalVolume()))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Avg. workouts volume")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.getAvgVolume())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Text("Avg. workouts duration")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.getAvgDuration())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
                Text("Main exercises")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            
                List() {
                    ForEach(viewModel.getMainExercises(), id: \.0) { exercise in
                        exerciseLog(exercise: exercise)
                    }
                }.listStyle(.plain)
                
            }
            .padding()
            .navigationBarTitle("Statistics", displayMode: .inline)
        }
    }
    
}

extension StatisticsView {
    
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
