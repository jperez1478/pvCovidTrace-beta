//
//  LocationCell.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationCell: View {
    var location: PVLocations
    
    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Rectangle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    Text("Check in ")
                        .minimumScaleFactor(0.75)
                }
            }
            
            .padding(.leading)
        }
        
    }
}


struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: PVLocations(record: MockData.location))
    }
}
