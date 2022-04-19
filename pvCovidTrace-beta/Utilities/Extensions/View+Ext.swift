//
//  View+Ext.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }

    
    func embedInScrollView() -> some View{
        GeometryReader{ geometry in
            ScrollView{
                self.frame(minWidth: geometry.size.height, maxHeight: .infinity)
            }
            
        }
    }

//this help dismiss the keybaord
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
