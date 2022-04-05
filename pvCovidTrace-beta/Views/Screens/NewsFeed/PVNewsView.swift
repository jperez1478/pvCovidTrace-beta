//
//  PVNewsView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct PVNewsView: View {
    
    
    var news: [News] = NewsList.PvNews
    
    var body: some View {
        NavigationView{
            List(news, id: \.id){ news in
                NavigationLink(destination: NewsDetailView(news: news),label:{
                    NewsCell(news: news)
                })
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal){
                        HStack{
                            Image("pvmap")
                                .resizable()
                                .scaledToFit()
                            Text("News")
                                .font(.title)
                                .fontWeight(.black)
                                .padding(5)
                        }
                        
                    }
                }
            }
        }
    }
}

struct NewsCell: View{
    var news: News
    
    var body: some View{
        VStack(alignment:.leading){
            Image (news.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading){
                Text(news.title)
                    .font(.title)
                    .fontWeight(.black)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                Text (news.description)
                    .font(.headline)
                
            }
        }

    }
}

struct PVNewsView_Previews: PreviewProvider {
    static var previews: some View {
        PVNewsView()
    }
}
