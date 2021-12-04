//
//  HomeView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                
                AboutView()
                
                Spacer()
            }
            .background(Color(red: 0.965, green: 0.961, blue: 0.939))
            .navigationTitle("Bookshelf")
        }
        
        
    }
}

struct AboutView: View{
    var body: some View{
        VStack{
            Text("Over Bookshelf").fontWeight(.bold).padding(10.0)
            Text("Bookshelf is een website gemaakt in samenwerking met bibliotheek De Krook. Op onze website kunt u onze catalogus raadplegen en boeken toevoegen aan uw favorieten. Daarnaast kunt u ook een plaats reserveren in bibliotheek De Krook om te studeren.")
                .padding(10.0)
        }
        .background(Color.white)
        .frame(width: nil)
        .cornerRadius(5)
        .padding(30.0)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
