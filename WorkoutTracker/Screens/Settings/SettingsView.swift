//
//  SettingsView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

/**
 Screena slúži na nastavenie jednotiek váhy a vzdialenosti v aplikácii
 */
struct SettingsView: View {
    
    @ObservedObject var settingsView = SettingViewModel()
    @State var showModal = false
    
     // MARK: - Body
    
    /**
    Obsahuje picker pre jednotky vzdialenosti  a vahy . Taktiež aj App Guide
     */
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                
                header(text: "Weight")
                    .padding(.top, 8)
                Picker("Weight", selection: $settingsView.weight) {
                    Text("KG")
                        .tag(Weight.kg)
                    Text("LBS")
                        .tag(Weight.lbs)
                }
                .pickerStyle(.segmented)
                
                header(text: "Distance")
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

private extension SettingsView {
    
    /**
     Funkcie na zobrazenie hlavičky
     
     Parameters:
     - text: String
     
     Returns:
     - some View
     */
    func header(text: String) -> some View {
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
    
}
