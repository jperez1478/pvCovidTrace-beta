//
//  Mapballon.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/11/22.
//

import SwiftUI

struct Mapballon: Shape {
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: CGPoint(x:rect.midX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint (x: rect.midX, y:rect.minY),
                          control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint (x: rect.midX, y:rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }

}

struct Mapballon_Previews: PreviewProvider {
    static var previews: some View {
        Mapballon()
            .frame(width: 300, height: 240)
            .foregroundColor(.brandPrimary)
    }
}
