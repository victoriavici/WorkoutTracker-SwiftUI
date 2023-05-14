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
        .init(name: "Settings", description: "Set your preffered units of weight and distance", imageUrl: "settings", tag: 0),
        .init(name: "druha", description: "druha", imageUrl: "", tag: 1),
        .init(name: "tretia", description: "tretia", imageUrl: "", tag: 2),
    ]
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
    
}
