//
//  NavigationLinkLazyView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 13/05/2023.
//

import SwiftUI

/**
 Generickým view typ, ktorý slúži na lenivú inizializáciu obsahu view.
 */
struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
    
}
