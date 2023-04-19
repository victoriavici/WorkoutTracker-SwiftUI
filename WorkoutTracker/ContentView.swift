//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .phone)
    }
    
    var body: some View {
        
        TabView {
            WorkoutView()
                .tabItem {
                    Image(systemName: "dumbbell")
                }
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            AboutView()
                .tabItem {
                    Image(systemName: "info.square")
                }
        }.tabViewStyle(.automatic)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}
