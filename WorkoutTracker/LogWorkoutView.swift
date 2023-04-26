//
//  LogWorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
import RealmSwift

struct LogWorkoutView: View {
    
    // MARK: - Variables
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = LogWorkoutViewModel()
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(alignment: .center,spacing: 50) {
                VStack {
                    Text("Time")
                    Text("xxxx")
                }
                .padding(.vertical)
                VStack {
                    Text("Volume")
                    Text("xxxx")
                }
                .padding()
            }
            .padding(.horizontal, 20)
            List {
                ForEach(viewModel.allEx) { exercise in
                    
                    header(exerciseName: exercise.name)
                    ForEach(exercise.sets, id: \.self) { index in
                        setRow(index: index)
                            .id(index)
                    }
                    addSetButton(exercise: exercise)
                    Spacer()
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    addExercise()
                    HStack {
                        addDiscardAndFinishButton(text: "Discard") {}
                        addDiscardAndFinishButton(text: "Finish") {}
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle("Log workout", displayMode: .inline)
    }
    
}


// MARK: - Components

private extension LogWorkoutView {
    
    func header(exerciseName: String) -> some View {
        VStack(alignment: .leading) {
            Text(exerciseName)
                .font(.headline)
            
            HStack(spacing: 8) {
                Text("SET")
                    .frame(width: 48)
                    .fixedSize(horizontal: true, vertical: false)
                
                Text("PREVIOUS")
                    .frame(maxWidth: .infinity)
                
                Text("KG")
                    .frame(maxWidth: .infinity)
                
                Text("REPS")
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 24)
    }
    
    func setRow(index: Int) -> some View {
        HStack(spacing: 8) {
            Text("\(Int(index))")
                .frame(width: 48)
            
            Text("-")
                .frame(maxWidth: .infinity)
            
            TextField("kg", value: $viewModel.weight, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            
            TextField("reps", value: $viewModel.reps, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
        .frame(height: 24)
    }
    
    func addSetButton(exercise: Exercise) -> some View {
        Button {
            let lastIndex = viewModel.allEx.lastIndex(where: { $0.id == exercise.id }) ?? 0
            viewModel.addSet(index: lastIndex)
        } label: {
            Text("+ ADD SET")
                .frame(maxWidth: .infinity, maxHeight: 8)
                .font(.title3)
                .foregroundColor(.black)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(3)
        }
    }
    
    func addExercise() -> some View {
        ZStack {
            Text("+ ADD EXERCISE")
                .frame(maxWidth: .infinity, maxHeight: 8)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(Color.blue)
                .cornerRadius(3)
            
            NavigationLink(destination: AddExerciseView(), label: {})
                .opacity(0)
        }
    }
    
    func addDiscardAndFinishButton(text: String, action: @escaping () -> Void) -> some View {
        VStack {
            Button {
                action()
            } label: {
                Text(text)
                    .frame(maxWidth: .infinity, maxHeight: 8)
                    .font(.title2)
                    .foregroundColor(text == "Discard" ? .red : .blue)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray.opacity(0.3)).foregroundColor(.white))
                    .cornerRadius(3)
            }
        }
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct LogWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogWorkoutView()
    }
    
}
