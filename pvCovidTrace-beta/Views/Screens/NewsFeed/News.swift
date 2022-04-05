//
//  News.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/5/22.
//

import SwiftUI

struct News: Identifiable{
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let url: URL
}


struct NewsList{
    static let PvNews = [
        News(imageName: "Icon-72",
             title: "Prairie View Current Cases update",
             description: "Prairie View A&M recieves updates on the amount of people that have recieved cases daily. The University displays the number of Reported Covid-19 Cases on this site daily.",
             url: URL(string: "https://www.pvamu.edu/coronavirus/reported-cases/")!),
        
        News(imageName: "Icon-72",
             title: "Announcements about Covid-19",
             description: "Covid-19 is a serious topic for Priaire View A&M University and the students saftey is our main priority. We use this page to consistently display announcements that we want out community to know in concerns of the Covid-19 Virus. Not only will this page hold announcements for Covid-19, but also general announcements will be displayed",
             url: URL(string: "https://www.pvamu.edu/coronavirus/announcements/")!),
        News(imageName: "Icon-72",
             title: "Need to Schedule a Covid-19 Test on Campus",
             description: "This is the registration site for all individuals that would like to get tested on Prairie View's Campus",
             url: URL(string: "https://tamus.curativeinc.com/welcome")!)
    ]
}
