//
//  PVAnnotation.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/11/22.
//

import SwiftUI

struct PVAnnotation: View {
    
    var location: PVLocations
    var number: Int
    
    var body: some View {
        VStack{
            ZStack{
                Mapballon()
                    .frame(width: 100, height: 70)
                    .foregroundColor(.brandPrimary)
                Image(uiImage: location.squareImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -11)
                
                
                if number > 0 {
                    Text("\(min(number, 99))")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 26, height: 18)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .offset(x: 20, y: -28)
                }
               
            }
            
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
            
            Text(location.positive)
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.red)

        }
        .accessibilityLabel(Text("Map Pin \(location.name) \(number) checked in."))
        
        .accessibilityLabel(Text("Positive \(location.positive)\(number) positive case"))
    }
}

struct PVAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        PVAnnotation(location: PVLocations(record: MockData.location), number: 44)
    }
}
