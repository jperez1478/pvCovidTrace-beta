//
//  LocationDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        NavigationView {
            VStack{
                Image("banner-72")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                HStack {
                    Label("123 Main Street", systemImage: "mapping.and.ellipse")
                }
        
        Spacer()
    }
        .navigationTitle("LocationName")
        .navigationBarTitleDisplayMode(.inline)
}
        
    }
}


struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}
