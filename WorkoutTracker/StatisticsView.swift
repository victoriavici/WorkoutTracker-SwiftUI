//
//  StatisticsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Statistisc View")
            }
            .navigationBarTitle("Statistics", displayMode: .inline)
        }
    }
    
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
