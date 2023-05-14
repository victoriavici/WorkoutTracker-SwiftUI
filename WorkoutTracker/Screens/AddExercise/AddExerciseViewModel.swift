//
//  AddExerciseViewModel.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 27/04/2023.
//

import Foundation
import Combine


class AddExerciseViewModel: ObservableObject, Identifiable {
    
    lazy var requestManager: RequestManagerType = RequestManager(baseURL: .base)
    @Published var selectedExercises: [Exercises] = []
    @Published var listOfExercises: [Exercises] = [] {
        didSet {
            updateExercises()
        }
    }
    @Published var exercises: [Exercises] = []
    @Published var searchText: String = "" {
        didSet {
            updateExercises()
        }
    }
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading: Status = .loading
    
    init() {
        updateExercises()
        loadData()
    }
    
    func loadData() {
        isLoading = .loading
        DispatchQueue.global(qos: .background).async {
            self.requestManager.fetchData()
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        self.isLoading = .error
                        print(error)
                    case .finished:
                        self.isLoading = .success
                    }
                }, receiveValue: { exercises in
                    var exercises = exercises
                    exercises.data += CacheManager.shared.userExercises
                    self.listOfExercises = exercises.data.reduce(into: []) { result, element in
                        if !result.contains(element) {
                            result.append(element)
                        }
                    }
                    self.listOfExercises.sort { exercises1, exercises2 in
                        exercises1.name < exercises2.name
                    }
                })
                .store(in: &self.cancellables)
        }
    }

    private func updateExercises() {
        exercises = searchText.isEmpty ? listOfExercises : listOfExercises.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func selectExercise(selected: Exercises) {
        if let index = selectedExercises.firstIndex(where: { $0.id == selected.id }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(selected)
        }
    }
    
    func createExercise(name: String) {
        listOfExercises.append(Exercises(name: name))
        CacheManager.shared.userExercises.append(Exercises(name: name))
    }
    
}





