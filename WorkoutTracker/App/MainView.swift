//
//  ContentView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct MainView: View {
    
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

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .tabViewStyle(.automatic)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
    
}