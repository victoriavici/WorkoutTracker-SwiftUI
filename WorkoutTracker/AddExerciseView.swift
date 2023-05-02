//
//  AddExerciseView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 26/04/2023.
//

import SwiftUI

struct AddExerciseView: View {
    
    // MARK: - Variables

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = AddExerciseViewModel()
    
    let action: ([Exercises]) -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.exercises) { exercise in
                        let isSelected = viewModel.selectedExercises.contains(where: { $0.id == exercise.id })
                        Button {
                            viewModel.selectExercise(selected: exercise)
                        } label: {
                            HStack {
                                Text(exercise.name)
                                    .multilineTextAlignment(.leading)
                                if isSelected {
                                    Image(systemName: "checkmark")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(.blue)
                                } else {
                                    Rectangle()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
                    }
                }
                .foregroundColor(.black)
            }
            .searchable(text: $viewModel.searchText)
                        
            if viewModel.selectedExercises.count > 0 {
                addButton()
            }
        }
        .navigationBarTitle("Add exercise")
        .navigationBarItems(trailing: NavigationLink(destination: CreateExerciseView { name in viewModel.createExercise(name: name)}) {
            Text("Create")
            })
        .padding()
    }
    
}

// MARK: - Components

extension AddExerciseView {
    
    func addButton() -> some View {
        VStack {
            Button {
                action(viewModel.selectedExercises)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add \(viewModel.selectedExercises.count) exercise")
                    .frame(maxWidth: .infinity, maxHeight: 8)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(3)
            }
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView {_ in }
    }
    
}
