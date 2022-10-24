//
//  MiniPlayerViewModel.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 20.10.22.
//

import Foundation

final class MiniPlayerViewModel: ObservableObject {
    @Published private(set) var tracks: [Track] = []
    @Published private(set) var previousTrack: Track?
    @Published private(set) var currentTrack: Track = .empty
    @Published private(set) var nextTrack: Track?
    @Published private(set) var isPlaying: Bool = false

    public var swipeSession = ""

    var showsMiniPlayer: Bool {
        currentTrack != .empty
    }

    private let playbackService: PlaybackService

    init(playbackService: PlaybackService = PlaybackService()) {
        self.playbackService = playbackService
        setupBindings()
    }

    func setupBindings() {
        playbackService.observeQueue()
            .receive(on: DispatchQueue.main)
            .assign(to: &$tracks)

        playbackService.observePreviousTrack()
            .receive(on: DispatchQueue.main)
            .assign(to: &$previousTrack)

        playbackService.observeCurrentTrack()
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentTrack)

        playbackService.observeNextTrack()
            .receive(on: DispatchQueue.main)
            .assign(to: &$nextTrack)

        playbackService.observeIsPlaying()
            .receive(on: DispatchQueue.main)
            .assign(to: &$isPlaying)
    }
}

extension MiniPlayerViewModel {
    func didTap(on track: Track) {
        playbackService.play(track)
    }

    func togglePlayback() {
        playbackService.togglePlayback()
    }

    func skipBackward() {
        playbackService.skipBackward()
    }

    func skipForward() {
        playbackService.skipForward()
    }
}
