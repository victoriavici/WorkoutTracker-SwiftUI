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
                    if Double(UIDevice.current.systemVersion) ?? 0 >= 16.0 {
                        Image(systemName: "dumbbell.fill")
                    } else {
                        Image(systemName: "scalemass")
                    }
                }

            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }

            AboutView()
                .tabItem {
                    if Double(UIDevice.current.systemVersion) ?? 0 >= 16.0 {
                        Image(systemName: "info.square")
                    } else {
                        Image(systemName: "info")
                    }
                }
        }
        .tabViewStyle(.automatic)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
    
}
