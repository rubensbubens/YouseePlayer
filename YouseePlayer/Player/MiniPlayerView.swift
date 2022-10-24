//
//  MiniPlayerView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 20.10.22.
//

import Foundation
import SwiftUI

struct MiniPlayerView: View {
    @StateObject var viewModel = MiniPlayerViewModel()

    @State private var swipeSession: String?

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(viewModel.tracks) { track in
                    TrackCell(
                        title: track.title,
                        artist: track.artist,
                        isCurrent: viewModel.currentTrack == track,
                        isPlaying: viewModel.isPlaying
                    )
                    .onTapGesture {
                        viewModel.didTap(on: track)
                    }
                }
            }

            if viewModel.showsMiniPlayer {
                HStack(spacing: 8) {
                    TrackCover(color: .green)
                        .padding(.leading, 16)

                    SwipeTrackView(
                        previousTrack: { makeView(for: viewModel.previousTrack) },
                        currentTrack: { makeView(for: viewModel.currentTrack) },
                        nextTrack: { makeView(for: viewModel.nextTrack) },
                        skipBackward: viewModel.skipBackward,
                        skipForward: viewModel.skipForward
//                        swipes: { isSwiping in
//                            swipeSession = isSwiping ? viewModel.swipeSession : nil
//                        }
                    )
                    .frame(height: 60)
                    .padding(8)
//                    .clipShape(Rectangle())
//                    .fadeGradient([.leading, .trailing], length: swipeSession != nil ? 16 : 0)

                    Button {
                        viewModel.togglePlayback()
                    } label: {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .imageScale(.large)
                            .foregroundColor(.green)
                            .padding(.trailing, 24)
                    }
                }
                .background(
                    Color(uiColor: UIColor.systemBackground)
                )
            }

            Divider()
        }
        .animation(.easeInOut, value: viewModel.showsMiniPlayer)
        .animation(.easeInOut, value: viewModel.currentTrack)
    }

    private func makeView(for track: Track?) -> TrackInfoView? {
        guard let track else { return nil }

        return TrackInfoView(
            title: track.title,
            artist: track.artist
        )
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView()
    }
}
