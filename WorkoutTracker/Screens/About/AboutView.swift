//
//  AboutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

struct AboutView: View {
    
    @ObservedObject var viewModel = AboutViewModel()
    let pages = Pages().pages
    @State var pageIndex = 0
    let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $pageIndex) {
                       ForEach(pages) { page in
                           VStack {
                               Spacer()
                               pageView(page: page)
                               Spacer()
                           }
                           .tag(page.tag)
                       }
                   }
                   .animation(.easeInOut, value: pageIndex)
                   .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                   .tabViewStyle(.page)
                   .onAppear {
                       dotAppearance.currentPageIndicatorTintColor = .blue
                       dotAppearance.pageIndicatorTintColor = .gray
                   }
               }
            .navigationBarTitle("About app", displayMode: .inline)
        
        }
    
}
extension AboutView {
    
    func text(text: String) -> some View {
        Text(text)
            .padding(.top, 5.0)
            .foregroundColor(Color.blue)
    }
    
    func pageView(page: Page) -> some View {
        VStack() {
            Image("\(page.imageUrl)")
                .resizable()
                .cornerRadius(30)
               
                .scaledToFit()
                .padding()
                .frame(maxHeight: 500)
                .shadow(radius: 16)
               
            
            Text(page.name)
                .font(.title)
                .foregroundColor(.black)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
                .foregroundColor(.black)

        }
    }
    
    
}

struct Page: Identifiable, Equatable {
    
    var id: String {
        name
    }
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
}

struct Pages: Equatable {
     let pages: [Page] = [
        .init(name: "Workouts", description: "Start a new workout or browse through your workout history", imageUrl: "workout", tag: 0),
        .init(name: "Log your workout", description: "Track your workout by logging the number of reps and weights for each set of exercises", imageUrl: "logworkout", tag: 1),
        .init(name: "Add exercises", description: "Add exercises to your current workout", imageUrl: "add", tag: 2),
        .init(name: "Create exercise", description: "If you can't find the exercise you are looking for, add it to your list", imageUrl: "create", tag: 3),
        .init(name: "Statistics", description: "Review the statistics of your workout", imageUrl: "stats", tag: 4),
        .init(name: "Exercise stats", description: "Review the statistics and graphs of exercises", imageUrl: "exStats", tag: 5),
        .init(name: "Settings", description: "Set your preffered units of weight and distance", imageUrl: "settings", tag: 6)
     ]
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
    
}
