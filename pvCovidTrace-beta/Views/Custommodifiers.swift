//
//  Custommodifiers.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct ProfileNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}
