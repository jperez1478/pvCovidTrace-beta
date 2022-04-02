//
//  SubmitButton.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import SwiftUI

struct submitButton: View {
    
var title: String

var body: some View {
    Text(title)
        .bold()
        .frame(width: 280, height: 44)
        .background(Color.brandPrimary)
        .foregroundColor(.white)
        .cornerRadius(8)
}
}



struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        submitButton(title: "Submit Status")
    }
}
