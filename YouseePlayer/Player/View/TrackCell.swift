//
//  TrackCell.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import SwiftUI

struct TrackCell: View {
    let title: String
    let artist: String
    let isCurrent: Bool
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 16) {
            if isCurrent {
                TrackPlayingCover(isPlaying: isPlaying)
            } else {
                TrackCover(color: .gray)
            }
            TrackInfoView(
                title: title,
                artist: artist
            )
        }
    }
}

struct TrackCell_Previews: PreviewProvider {
    static var previews: some View {
        TrackCell(
            title: "Track title",
            artist: "Artist",
            isCurrent: true,
            isPlaying: true
        )
    }
}
