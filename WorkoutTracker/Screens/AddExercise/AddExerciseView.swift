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
    @ObservedObject var viewModel: AddExerciseViewModel
    @State var showingAlert = false
    
    let action: ([Exercises]) -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if viewModel.isLoading == .success {
                List {
                    ForEach(viewModel.exercises) { exercise in
                        let isSelected = viewModel.selectedExercises.contains(where: { $0.id == exercise.id })
                        Button {
                            viewModel.selectExercise(selected: exercise)
                        } label: {
                            HStack {
                                Text(exercise.name)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                if isSelected {
                                    Image(systemName: "checkmark")
                                        .frame(maxWidth: 10, alignment: .trailing)
                                        .foregroundColor(.blue)
                                } else {
                                    Rectangle()
                                        .frame(maxWidth: 10, alignment: .trailing)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.bottom, exercise == viewModel.exercises.last ? 48 : 0)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
                
                if viewModel.selectedExercises.count > 0 {
                    addButton()
                }
                
            } else if viewModel.isLoading == .loading{
                ProgressView("Loading...")
            } else {
                Text("Error!")
                Button {
                    viewModel.loadData()
                } label: {
                    Text("Retry loading")
                }
            }
        }
        .navigationBarTitle("Add exercise")
        .navigationBarItems(trailing: NavigationLink(destination: CreateExerciseView { name in viewModel.createExercise(name: name)}) {
            Text("Create")
        })
    }
    
}

// MARK: - Components

extension AddExerciseView {
    
    func addButton() -> some View {
        VStack {
            Button {
                action(viewModel.selectedExercises)
                presentationMode.wrappedValue.dismiss()
                viewModel.selectedExercises.removeAll()
                viewModel.searchText.removeAll()
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

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
            .padding()
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(viewModel: AddExerciseViewModel()) { _ in }
    }
    
}
