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
    @State private var heaviest = false
    @State private var session = false
    @State private var set = false
    @State private var reps = false
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Colors.BorderBlue, secondGradientColor: Colors.GradientPurple, textColor: Color.white, legendTextColor: Color.white, dropShadowColor: Color.blue )
    
    var body: some View {
        
        ScrollView {
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
                
                Spacer()
                HStack {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Graphs")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                DisclosureGroup("Session volume", isExpanded: $session) {
                    LineView(data: viewModel.getSessionData(name: name), style: chartStyle)
                        .frame(height: 300)
                    
                }
                .foregroundColor(.black)
                
                DisclosureGroup("Heaviest weight", isExpanded: $heaviest) {
                    LineView(data: viewModel.getHeaviestWeightData(name: name), style: chartStyle)
                        .frame(height: 300)
                    
                }
                .foregroundColor(.black)
                
                DisclosureGroup("Best set volume", isExpanded: $set) {
                    LineView(data: viewModel.getBestSetVolumeData(name: name), style: chartStyle)
                        .frame(height: 300)
                    
                }
                .foregroundColor(.black)
                

                DisclosureGroup("Total reps", isExpanded: $reps) {
                    LineView(data: viewModel.getTotalRepsData(name: name), style: chartStyle)
                        .frame(height: 300)
                }
                .foregroundColor(.black)
                
            }
            .padding()
        }
    }
}

struct ExerciseStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseStatsView(name: "name")
    }
}
