//
//  SwipeTrackCollectionView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import Foundation
import UIKit

class SwipeTrackCollectionView: UIView {
    // MARK: - Public

    var previousTrackView: UIView? {
        willSet {
            removeView(previousTrackView)
            scrollToCurrentTrack()
        }
        didSet {
            guard let previousTrackView else { return }

            trackViews.insert(previousTrackView, at: 0)
            collectionView.reloadData()
            scrollToCurrentTrack()
        }
    }

    var currentTrackView: UIView? {
        willSet {
            removeView(currentTrackView)
            scrollToCurrentTrack()
        }
        didSet {
            guard let currentTrackView else { return }

            trackViews.append(currentTrackView)
            collectionView.reloadData()
            scrollToCurrentTrack()
        }
    }

    var nextTrackView: UIView? {
        willSet {
            removeView(nextTrackView)
            scrollToCurrentTrack()
        }
        didSet {
            guard let nextTrackView else { return }

            trackViews.append(nextTrackView)
            collectionView.reloadData()
            scrollToCurrentTrack()
        }
    }

    var skipBackward: (() -> Void)?
    var skipForward: (() -> Void)?
    var swipes: ((Bool) -> Void)?

    // MARK: - Private

    private var trackViews: [UIView] = []

    // MARK: - UI

    private var collectionView: UICollectionView!

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension SwipeTrackCollectionView {
    func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.bounces = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeTrackCell.self, forCellWithReuseIdentifier: SwipeTrackCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func removeView(_ view: UIView?) {
        guard let view else { return }

        if trackViews.contains(view) {
            trackViews.removeAll(where: { $0 == view })
            collectionView.reloadData()
        }
    }

    func scrollToCurrentTrack() {
        guard trackViews.count > 1,
              let currentTrackView,
              let index = trackViews.firstIndex(of: currentTrackView)
        else {
            return
        }

        collectionView.scrollToItem(
            at: IndexPath(item: index, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
    }
}

// MARK: - UICollectionViewDataSource

extension SwipeTrackCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trackViews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeTrackCell.id, for: indexPath) as! SwipeTrackCell

        let view = trackViews[indexPath.item]
        cell.update(with: view)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SwipeTrackCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}

// MARK: - UIScrollViewDelegate

extension SwipeTrackCollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        swipes?(true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            handleSwipe(for: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleSwipe(for: scrollView)
    }

    private func handleSwipe(for scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.frame.size.width

        if contentOffsetX < scrollViewWidth {
            skipBackward?()
        } else if contentOffsetX == scrollViewWidth {
            // NOTE: Scroll back to current track. Do nothing...
        } else {
            skipForward?()
        }

        swipes?(false)
    }
}
