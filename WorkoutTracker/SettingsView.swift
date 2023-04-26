//
//  SettingsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsView = SettingViewModel()
    
     // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 8) {
            Text("Weight")
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            
            Picker("Weight", selection: $settingsView.weight) {
                Text("KG").tag(Weight.kg)
                Text("LBS").tag(Weight.lbs)
            }
            .pickerStyle(.segmented)
            
        
            Text("Distance")
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            Picker("Distance", selection: $settingsView.distance) {
                Text("KILOMETERS").tag(Distance.km)
                Text("MILES").tag(Distance.mi)
            }
            .pickerStyle(.segmented)
            
        }
        .padding(.horizontal)
        .navigationBarTitle("Settings")
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .top)
    }
    
}
// MARK: - Components

private extension SettingsView {

}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
    
}
