//
//  ExerciseStatsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import SwiftUI
import SwiftUICharts


struct ExerciseStatsView: View {
    
    @ObservedObject var viewModel = ExerciseStatsViewModel()
    var name: String
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                Image(systemName: "medal")
                Text("Personal Records")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Heaviest weight")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.getHeviestWeight(name: name))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack {
                Text("Best set volume")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.getBestSet(name: name))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack {
                Text("Best session volume")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.getBestSession(name: name))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
        .padding()
    }
    
}

struct ExerciseStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseStatsView(name: "name")
    }
}
