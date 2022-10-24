//
//  Track.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 20.10.22.
//

import Foundation

struct Track: Identifiable, Equatable {
    let id: String
    let title: String
    let artist: String
}

extension Track {
    static var empty: Track {
        .init(
            id: "0",
            title: "",
            artist: ""
        )
    }
}

extension Track {
    static let mockMetallica = Track(
        id: UUID().uuidString,
        title: "Unforgiven",
        artist: "Metallica"
    )

    static let mockBeatles = Track(
        id: UUID().uuidString,
        title: "Yellow submurine",
        artist: "Beatles"
    )

    static let mockMozart = Track(
        id: UUID().uuidString,
        title: "Symphony #5 (feat. Bach)",
        artist: "Mozart"
    )

    static let mockBeyonce = Track(
        id: UUID().uuidString,
        title: "Green Light",
        artist: "Beyonce"
    )

    static let mockAlmost = Track(
        id: UUID().uuidString,
        title: "Hands",
        artist: "The Almost"
    )

    static var mockedTracks: [Track] = [
        .mockBeatles,
        .mockMetallica,
        .mockMozart,
        .mockAlmost,
        .mockBeyonce
    ]
}
