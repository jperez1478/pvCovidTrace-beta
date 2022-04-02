//
//  XDismissButton.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/1/22.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        //Zstack to create the x button to dismiss the popup screen
        ZStack{
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.brandPrimary)
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .imageScale(.small)
                .frame(width: 44, height: 44)
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton()
    }
}
