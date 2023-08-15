//
//  LeagueAndSeriesView.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct LeagueAndSeriesView: View {
    
    var imageURL: String
    var league: String
    var series: String
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 10) {
                CachedAsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image.leagueModifier()
                    case .failure:
                        Image(systemName: StringConstants.circle).leagueIconModifier()
                    case .empty:
                        Image(systemName: StringConstants.circle).leagueIconModifier()
                    @unknown default:
                        ProgressView()
                    }
                }
                Text("\(league) + \(series)")
                    .font(Font.roboto(.Regular, size: 14))
                    .foregroundColor(.white)
                    .lineLimit(1)
            }.padding(8)
        }.padding(.leading, 16)
            .padding(.trailing, 8)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, maxHeight: 32, alignment: .leading)
    }
}
