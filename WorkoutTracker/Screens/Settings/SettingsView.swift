//
//  SettingsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsView = SettingViewModel()
    @State var showModal = false
     // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                
                Text("Weight")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 8)
                Picker("Weight", selection: $settingsView.weight) {
                    Text("KG")
                        .tag(Weight.kg)
                    Text("LBS")
                        .tag(Weight.lbs)
                }
                .pickerStyle(.segmented)
                
                Text("Distance")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Picker("Distance", selection: $settingsView.distance) {
                    Text("KILOMETERS")
                        .tag(Distance.km)
                    Text("MILES")
                        .tag(Distance.mi)
                }
                .pickerStyle(.segmented)
                Spacer()
                
                Button {
                    showModal = true
                } label: {
                    Text("App Guide")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                        .sheet(isPresented: $showModal) {
                            AboutView()
                        }
                }
                .padding()
                
                
            }
            .padding(.horizontal)
            .navigationBarTitle("Settings", displayMode: .inline)
            .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .top)
        }
    }
}
// MARK: - Components

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
    
}
