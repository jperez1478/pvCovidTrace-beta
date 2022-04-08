//
//  LoadingView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/8/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint:  .brandPrimary))
                .scaleEffect(2)
                .offset(y: -40)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
