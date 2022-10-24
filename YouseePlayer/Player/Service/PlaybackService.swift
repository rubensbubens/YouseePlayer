//
//  PlaybackService.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import Combine
import Foundation

final class PlaybackService {
    @Published private var tracks: [Track] = Track.mockedTracks
    @Published private var previousTrack: Track?
    @Published private var currentTrack: Track = .empty
    @Published private var nextTrack: Track?
    @Published private var isPlaying: Bool = false
}

extension PlaybackService {
    func play(_ track: Track) {
        currentTrack = track
        previousTrack = findTrack(before: currentTrack)
        nextTrack = findTrack(after: currentTrack)
        isPlaying = true
    }

    func skipBackward() {
        if let track = findTrack(before: currentTrack) {
            play(track)
        }
    }

    func skipForward() {
        if let track = findTrack(after: currentTrack) {
            play(track)
        }
    }

    func togglePlayback() {
        isPlaying.toggle()
    }
}

extension PlaybackService {
    func observeQueue() -> AnyPublisher<[Track], Never> {
        $tracks.eraseToAnyPublisher()
    }

    func observePreviousTrack() -> AnyPublisher<Track?, Never> {
        $previousTrack.eraseToAnyPublisher()
    }

    func observeCurrentTrack() -> AnyPublisher<Track, Never> {
        $currentTrack
//            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func observeNextTrack() -> AnyPublisher<Track?, Never> {
        $nextTrack.eraseToAnyPublisher()
    }

    func observeIsPlaying() -> AnyPublisher<Bool, Never> {
        $isPlaying.eraseToAnyPublisher()
    }
}

private extension PlaybackService {
    func findTrack(after track: Track?) -> Track? {
        guard let index = tracks.firstIndex(where: { track == $0 }) else {
            return nil
        }

        guard index + 1 < tracks.count else {
            return nil
        }

        return tracks[index + 1]
    }

    func findTrack(before track: Track?) -> Track? {
        guard let index = tracks.firstIndex(where: { track == $0 }) else {
            return nil
        }

        guard index - 1 >= 0 else {
            return nil
        }

        return tracks[index - 1]
    }
}
