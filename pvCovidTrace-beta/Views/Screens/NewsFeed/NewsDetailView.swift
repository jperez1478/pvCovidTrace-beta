//
//  NewsDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/5/22.
//

import SwiftUI

struct NewsDetailView: View {
    
    var news: News
    
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            Image(news.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(12)
            Text(news.title)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text(news.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            Link(destination: news.url, label:{
                Text("Navigate to Site")
                    .bold()
                    .font(.title2)
                    .frame(width: 280, height: 50)
                    .background(Color(.systemPurple))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
        }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(news: NewsList.PvNews.first!)
    }
}
