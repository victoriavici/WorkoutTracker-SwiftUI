//
//  ExerciseStatsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 02/05/2023.
//

import SwiftUI
import SwiftUICharts

/**
 Screena zobrazuje štatistiky vybraného cviku
 */
struct ExerciseStatsView: View {
    
    @ObservedObject var viewModel = ExerciseStatsViewModel()
    @State private var heaviest = false
    @State private var session = false
    @State private var set = false
    @State private var reps = false
    var name: String
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Colors.BorderBlue, secondGradientColor: Colors.GradientPurple, textColor: Color.white, legendTextColor: Color.white, dropShadowColor: Color.blue )
    
    // MARK: - Body
    
    /**
     Zobrazuje štatistiky a grafy pre cvik
     */
    var body: some View {
        
        ScrollView {
            VStack(spacing: 8) {
                
                textHeader(text: "Personal Records", image: "medal")

                textRow(text: "Heaviest weight", result: viewModel.getHeviestWeight(name: name))
                textRow(text: "Best set volume", result: viewModel.getBestSet(name: name))
                textRow(text: "Best session volume", result: viewModel.getBestSession(name: name))

                Spacer()
                
                textHeader(text: "Graphs", image: "chart.xyaxis.line")

                graph(text: "Session volume", isExpanded: $session, data: viewModel.getSessionData(name: name))
                graph(text: "Heaviest weight", isExpanded: $heaviest, data: viewModel.getHeaviestWeightData(name: name))
                graph(text: "Best set volume", isExpanded: $set, data: viewModel.getBestSetVolumeData(name: name))
                graph(text: "Total reps", isExpanded: $reps, data: viewModel.getTotalRepsData(name: name))
                
            }
            .padding()
        }
        .navigationBarTitle(name)
    }
}

private extension ExerciseStatsView {
    
    /**
     Funkcia slúžii na zobrazenie hlavičky
     
     Parameters:
     - text: String, image: String
     Returns:
     - some View
     */
    func textHeader(text: String, image: String) -> some View {
        HStack {
            Image(systemName: image)
            Text(text)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /**
     Funkcia slúžii na zobrazenie riadku štatistiky
     
     Parameters:
     - text: String, result: String
     Returns:
     - some View
     */
    
    func textRow(text: String, result: String) -> some View {
        HStack {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(result)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    /**
     Funkcia slúžii na zobrazenie grafu pre cvik
     
     Parameters:
     - text: String, isExpanded: Binding<Bool>, data: [Double]
     Returns:
     - some View
     */
    func graph(text: String, isExpanded: Binding<Bool>, data: [Double]) -> some View {
        DisclosureGroup(text, isExpanded: isExpanded) {
            LineView(data: data, style: chartStyle)
                .frame(height: 300)
        }
        .foregroundColor(.black)
    }
}

struct ExerciseStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseStatsView(name: "name")
    }
}
