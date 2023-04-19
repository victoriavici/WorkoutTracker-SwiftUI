//
//  AboutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        NavigationView {
            VStack() {
                Text("About View")
            }
            .navigationBarTitle("About app", displayMode: .inline)
        }
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
