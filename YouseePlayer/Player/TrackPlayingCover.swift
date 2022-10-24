//
//  TrackPlayingCover.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import SwiftUI

struct TrackPlayingCover: View {
    let isPlaying: Bool

    var body: some View {
        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
            .imageScale(.large)
            .foregroundColor(.green)
            .frame(maxWidth: 50, maxHeight: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.green, lineWidth: 2)
            )
    }
}

struct TrackPlayingCover_Previews: PreviewProvider {
    static var previews: some View {
        TrackPlayingCover(isPlaying: true)
    }
}
