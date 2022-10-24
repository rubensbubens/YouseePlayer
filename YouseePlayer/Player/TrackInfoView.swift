//
//  TrackInfoView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import SwiftUI

struct TrackInfoView: View {
    let title: String
    let artist: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(artist)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct TrackInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrackInfoView(title: "Track title", artist: "Artist")
    }
}
