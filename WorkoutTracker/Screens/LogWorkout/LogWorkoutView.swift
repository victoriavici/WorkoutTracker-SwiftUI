//
//  LogWorkoutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI
/**
 Screena na značenie aktuálne vykonávanom workoute
 */
struct LogWorkoutView: View {
    
    // MARK: - Variables
    
    @State private var keyboardIsActive = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LogWorkoutViewModel

    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(alignment: .center, spacing: 28) {
                currentWorkoutInfo(text: "Time", result: viewModel.time)
                currentWorkoutInfo(text: "Volume", result: String(viewModel.volume))
                currentWorkoutInfo(text: "Sets", result: String(viewModel.sets))
            }
            .padding(.horizontal, 24)
            
            ScrollViewReader { scrollview in
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
                    .id(0)
                }
                .listStyle(.plain)
                .onAppear() {
                    withAnimation(.spring(blendDuration: 0.3)) {
                        scrollview.scrollTo(0)
                    }
                }
                .padding(8)
            }
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle("Log workout", displayMode: .inline)
        .onAppear {
            if CacheManager.shared.currentWorkout == nil {
                viewModel.setStartTime()
            } else {
                viewModel.resumeWorkout()
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
        .overlay(alignment: .bottom) {
            Group {
                if keyboardIsActive
                {
                    Button {
                        hideKeyboard()
                    } label: {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                    }
                    .padding(8)
                    .padding(.horizontal, 14)
                }
            }
        }
    }
}

// MARK: - Components

private extension LogWorkoutView {
    /**
     Služi na zobrazenie workout infa
     
     Parameters:
     - text: String, result: String
     
     Returns:
     - some View
     */
    func currentWorkoutInfo(text: String, result: String) -> some View {
        VStack {
            Text(text)
            Text(result)
        }
        .frame(width: 72)
        .padding()
    }
    
    /**
     Služi na zobrazenie hlavičky cviku
     
     Parameters:
     - exercise: Exercise
     
     Returns:
     - some View
     */
    func header(exercise: Exercise) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(exercise.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                Button {
                    withAnimation() {
                        hideKeyboard()
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
    
    /**
     Zobrazenie riadku setu
     
     Parameters:
     - exercise: Exercise, index: Int
     
     Returns:
     - some View
     */
    func setRow(exercise: Exercise, index: Int) -> some View {
        HStack(spacing: 8) {
            Text("\(Int(index))")
                .frame(width: 48)
            
            if let exercise = viewModel.previousExercises.first(where: { exer in
                exer.name == exercise.name
            }),
               let sety = exercise.sets[safe: index - 1] {
                Text(String(format: "%.2f%@", viewModel.isWeightInKg ? sety.weight : sety.weight * C.kgToLbsMultiplayer, viewModel.isWeightInKg ? "kg" : "lbs") + " x \(sety.reps)")
                    .frame(maxWidth: .infinity)
            } else {
                Text("-")
                    .frame(maxWidth: .infinity)
            }
            let exIndex = getIndexExercise(exercise: exercise)
            
            TextField(viewModel.isWeightInKg ? "kg" : "lbs", value: $viewModel.allEx[exIndex].sets[index - 1].weight, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    keyboardIsActive = true
                }
            
            TextField("reps", value: $viewModel.allEx[exIndex].sets[index - 1].reps, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    keyboardIsActive = true
                }
            
        }
        .frame(height: 24)
        
    }
    /**
     Funkcia na zobrazenie buttona pre pridanie setu
     
     Parameters:
     - exercise: Exercise, index: Int
     
     Returns:
     - some View
     */
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
    
    /**
     Button pre pridanie cviku
     
     Returns:
     - some View
     */
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
            
            NavigationLink("", destination:  NavigationLazyView(AddExerciseView(viewModel: AddExerciseViewModel()) { exercises in viewModel.addExercise(selected: exercises)}))
                .opacity(0)
        }
    }
    
    /**
     Button pre zrušenie alebo uloženie workoutu
     
     Parameters:
     - text: String, action: @escaping () -> Void
     
     Return:
     - some View
     */
    func addDiscardAndFinishButton(text: String, action: @escaping () -> Void) -> some View {
        VStack {
            Button {
                action()
                if text == "Finish" {
                    viewModel.saveWorkout()
                }
                viewModel.clearWorkout()
                presentationMode.wrappedValue.dismiss()
                CacheManager.shared.currentWorkout = nil
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
    /**
     Funkcia pre získanie indexu cviku
     
     Parameters:
     - exercise: Exercise
     
     Returns:
     - Int
     */
    func getIndexExercise(exercise: Exercise) -> Int {
        return viewModel.allEx.firstIndex(where: {exercise.id == $0.id}) ?? 0
    }
    /**
     Funkcia skrýva klávsenicu
     */
    func hideKeyboard() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
        keyboardIsActive = false
    }
    
}

struct LogWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogWorkoutView(viewModel: LogWorkoutViewModel())
    }
    
}
