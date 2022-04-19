//
//  hapticManager.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/18/22.
//

import UIKit

struct HapticManager{
    static func playSuccess(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
