//
//  SwipeTrackView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 20.10.22.
//

import SwiftUI
import UIKit

struct SwipeTrackView<Content: View>: UIViewRepresentable {
    var previousTrack: () -> Content?
    let currentTrack: () -> Content
    var nextTrack: () -> Content?
    var skipBackward: () -> Void
    var skipForward: () -> Void
    var swipes: ((Bool) -> Void)?

    func makeUIView(context: Context) -> some UIView {
        let view = SwipeTrackCollectionView()
        view.skipBackward = skipBackward
        view.skipForward = skipForward
        view.swipes = swipes
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let view = uiView as? SwipeTrackCollectionView else {
            assertionFailure("Missing view")
            return
        }

        // NOTE: short delay to let view define its frame
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            view.previousTrackView = map(content: previousTrack())
            view.currentTrackView = map(content: currentTrack())
            view.nextTrackView = map(content: nextTrack())
        }
    }

    private func map(content: Content?) -> UIView? {
        guard let content else { return nil }

        let controller = UIHostingController(rootView: content)
        return controller.view
    }
}
