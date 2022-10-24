//
//  TrackCover.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import SwiftUI

struct TrackCover: View {
    let color: Color

    var body: some View {
        Image(systemName: "music.note.list")
            .resizable()
            .foregroundColor(color)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 2)
            )
            .frame(maxWidth: 50, maxHeight: 50)
    }
}

struct TrackCover_Previews: PreviewProvider {
    static var previews: some View {
        TrackCover(color: .green)
    }
}
