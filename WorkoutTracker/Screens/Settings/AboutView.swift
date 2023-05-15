//
//  AboutView.swift
//  WorkoutTracker
//
//  Created by Victoria Gáliková on 18/04/2023.
//

import SwiftUI

/**
 Prievodca aplikáciou
 */
struct AboutView: View {
    
    let pages = Pages().pages
    @State var pageIndex = 0
    let dotAppearance = UIPageControl.appearance()
     
    // MARK: - Body
    
    /**
     Zobrazuje screenshoty aplikacie s popisom
     */
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

// MARK: - Components

extension AboutView {
    /**
     Funkcia slúži na zobrazenie obrázku obrazovky, nadpisu a popisu k nej
     
     Parameters:
     - page: Page
     
     Returns:
     - some View
     */
    func pageView(page: Page) -> some View {
        VStack() {
            Image("\(page.imageUrl)")
                .resizable()
                .cornerRadius(30)
                .scaledToFit()
                .padding()
                .frame(maxHeight: 500)
                .shadow(radius: 16)
               
            Text(page.title)
                .font(.title)
                .foregroundColor(.black)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
                .foregroundColor(.black)
        }
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
    
}
