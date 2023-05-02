//
//  LogWorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct LogWorkoutView: View {
    
    // MARK: - Variables
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = LogWorkoutViewModel()
    
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(alignment: .center, spacing: 28) {
                VStack {
                    Text("Time")
                    Text(String(viewModel.time))
                }
                .frame(width: 72)
                .padding()
                VStack {
                    Text("Volume")
                    Text(String(viewModel.volume))
                }
                .frame(width: 72)
                .padding()
                VStack {
                    Text("Sets")
                    Text(String(viewModel.sets))
                }
                .frame(width: 72)
                .padding()
            }
            .padding(.horizontal, 24)
            List {
                ForEach(viewModel.allEx) { exercise in
                    
                    header(exercise: exercise)
                    
                    ForEach(exercise.sets, id: \.set) { index in
                        setRow(exercise: exercise, index: index.set)
                            .id(index.set)
                    }
                    .onDelete { index in
                        viewModel.deleteSet(exercise: exercise, index: index)
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
        .onAppear {
            if !viewModel.inWorkout {
                viewModel.setInWorkout()
                viewModel.setStartTime()
            }
            
            viewModel.updateTime()
            viewModel.timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    viewModel.updateTime()
                }
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }
}

// MARK: - Components

private extension LogWorkoutView {
    
    func header(exercise: Exercise) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 150) {
                Text(exercise.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                Button {
                    withAnimation() {
                        viewModel.removeExercise(exercise: exercise)
                    }
                } label: {
                    Image(systemName: "xmark")
                        .frame(alignment: .trailing)
                        .foregroundColor(.red)
                }
                .frame(height: 44)
                .buttonStyle(BorderlessButtonStyle())
            }
            
            HStack(spacing: 8) {
                Text("SET")
                    .frame(width: 48)
                    .fixedSize(horizontal: true, vertical: false)
                
                Text("PREVIOUS")
                    .frame(maxWidth: .infinity)
                
                Text(viewModel.isWeightInKg ? "KG" : "LBS")
                    .frame(maxWidth: .infinity)
                
                Text("REPS")
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 24)
        .padding(.vertical)
    }
    
    func setRow(exercise: Exercise, index: Int) -> some View {
        HStack(spacing: 8) {
            Text("\(Int(index))")
                .frame(width: 48)
            
            Text("-")
                .frame(maxWidth: .infinity)
            
            let exIndex = getIndexExercise(exercise: exercise)
            
            TextField(viewModel.isWeightInKg ? "kg" : "lbs", value: $viewModel.allEx[exIndex].sets[index - 1].weight, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            
            TextField("reps", value: $viewModel.allEx[exIndex].sets[index - 1].reps, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
        .frame(height: 24)
    }
    
    func addSetButton(exercise: Exercise) -> some View {
        VStack {
            Button {
                withAnimation {
                    viewModel.addSet(index: getIndexExercise(exercise: exercise))
                }
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
        .frame(height: 44)
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
            
            NavigationLink(destination: AddExerciseView { exercises in viewModel.addExercise(selected: exercises)}, label: {})
                .opacity(0)
        }
    }
    
    func addDiscardAndFinishButton(text: String, action: @escaping () -> Void) -> some View {
        VStack {
            Button {
                action()
                viewModel.setInWorkout()
                if text == "Finish" {
                    viewModel.saveWorkout()
                }
                viewModel.clearWorkout()
                
                presentationMode.wrappedValue.dismiss()

            } label: {
                Text(text)
                    .frame(maxWidth: .infinity, maxHeight: 8)
                    .font(.title2)
                    .foregroundColor(text == "Discard" ? .red : .blue)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray.opacity(0.3)).foregroundColor(.white))
                
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        
    }
 
    func getIndexExercise(exercise: Exercise) -> Int {
        return viewModel.allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0

    }
    
}

struct LogWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogWorkoutView()
    }
    
}
