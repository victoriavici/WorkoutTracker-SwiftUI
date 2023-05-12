//
//  AboutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct AboutView: View {
    
    @ObservedObject var viewModel = AboutViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack() {
                
                switch viewModel.current {
                case 1:
                    text(text: "Workout history")
                case 2:
                    text(text: "Workout logging")
                case 3:
                    text(text: "Setting")
                default:
                    text(text: "")
                }
                
                Text("About View")
            }
            .navigationBarTitle("About app", displayMode: .inline)
        
        }
    }
    
}
extension AboutView {
    
    func text(text: String) -> some View {
        Text(text)
            .padding(.top, 5.0)
            .foregroundColor(Color.blue)
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
    
}
