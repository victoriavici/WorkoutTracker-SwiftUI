//
//  AddExerciseView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 26/04/2023.
//

import SwiftUI

/**
 Screen pre pridanie cvikov do workoutu
 */
struct AddExerciseView: View {
    
    // MARK: - Variables
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddExerciseViewModel
    @Environment(\.dismissSearch) private var dismissSearch
    @Environment(\.isSearching) var isSearching

    
    let action: ([Exercises]) -> Void
    
    // MARK: - Body
    
    /**
     Zobrazenie všetkých názvov cvikoch po načítaní. Ak nie je načítané zobrazuje sa loading. Ak zlyhá tak sa zobrazí error
     */
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
                        .listSectionSeparator(.hidden, edges: .bottom)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
                
                if viewModel.selectedExercises.count > 0 {
                    addButton()
                }
                
            } else if viewModel.isLoading == .loading {
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
    
    /**
     Funkcia pre zobrazenie buttonu na pridanie cvičenia
     
     Returns:
     - some View
     */
    func addButton() -> some View {
        VStack {
            Button {
                action(viewModel.selectedExercises)
                dismissSearch()
                presentationMode.wrappedValue.dismiss()
                viewModel.selectedExercises.removeAll()
                viewModel.searchText.removeAll()
                dismissSearch.callAsFunction()
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
