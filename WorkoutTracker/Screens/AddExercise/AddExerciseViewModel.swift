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
    
    // MARK: - Logic
    
    /**
     Inicializácia
     */
    init() {
        updateExercises()
        loadData()
    }
    
    /**
    Načítanie dát z requestManager a aktualizáciu  listOfExercises na základe týchto dát
     */
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

    /**
     Aktualizácia cvikov pri zadávaní textu do searchbaru
     */
    private func updateExercises() {
        exercises = searchText.isEmpty ? listOfExercises : listOfExercises.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    /**
     Funkcia slúži na označenie a odznačenie cvikov na pridanie
     
     Parameters:
     - selected: Exercises
     */
    func selectExercise(selected: Exercises) {
        if let index = selectedExercises.firstIndex(where: { $0.id == selected.id }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(selected)
        }
    }
    
    /**
     Pridanie nového cviku
     
     Parameters:
     - name: String
     */
    func createExercise(name: String) {
        listOfExercises.append(Exercises(name: name))
        CacheManager.shared.userExercises.append(Exercises(name: name))
    }
    
}
/**
 Enum statusu načítania api requestu
 */
enum Status: String {

    case loading
    case error
    case success
}





