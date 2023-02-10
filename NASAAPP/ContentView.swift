//
//  ContentView.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 18/01/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //Access current color scheme
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
            TabView {
                
                //calling apodview
                
                APODView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                //calling favview
                FavouriteView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
                    .tabItem {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("fav")
                    }
                
            //check for dark mode and change background accordingly
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
