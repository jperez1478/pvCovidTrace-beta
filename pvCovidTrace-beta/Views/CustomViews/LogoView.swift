//
//  LogoView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/1/22.
//

import SwiftUI

struct LogoView: View {
    
    var frameWidth: CGFloat
    
    var body: some View {
        Image(decorative: "Covid_logo1")
                .resizable()
                .scaledToFit()
                .frame(width : frameWidth)
                    
            }
        }



struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(frameWidth: 250)
    }
}
