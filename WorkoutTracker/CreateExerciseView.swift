//
//  CreateExerciseView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 28/04/2023.
//

import SwiftUI

struct CreateExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CreateExerciseViewModel()
    
    let action: (String) -> Void
    
    var body: some View {
        
        VStack {
            TextField("Write name of new exercise", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding()
            
            Button {
                action(viewModel.name)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Create")
                    .frame(maxWidth: 64, maxHeight: 8)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background(Color.blue)
                    .cornerRadius(3)
            }
        }
        .navigationTitle("Create exercise")
    }
}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseView {_ in }
    }
    
}

