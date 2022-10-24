//
//  SwipeTrackPageView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 24.10.22.
//

import Foundation
import UIKit
import SwiftUI

struct SwipeTrackPageView<Content: View> : UIViewControllerRepresentable {
    let previousTrack: () -> Content?
    let currentTrack: () -> Content
    let nextTrack: () -> Content?
    let skipBackward: () -> Void
    let skipForward: () -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = SwipeTrackPageViewController(
            currentController: map(content: currentTrack())!,
            skipBackward: skipBackward,
            skipForward: skipForward
        )

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let controller = uiViewController as? SwipeTrackPageViewController else { return }

        controller.previousController = map(content: previousTrack())
        controller.nextController = map(content: nextTrack())
    }

    private func map(content: Content?) -> UIViewController? {
        guard let content else { return nil }

        return UIHostingController(rootView: content)
    }
}

final class SwipeTrackPageViewController: UIPageViewController {
    var previousController: UIViewController?
    var currentController: UIViewController
    var nextController: UIViewController?
    let skipBackward: () -> Void
    let skipForward: () -> Void

    private var pendingViewController: UIViewController?

    init(
        currentController: UIViewController,
        skipBackward: @escaping () -> Void,
        skipForward: @escaping () -> Void
    ) {
        self.currentController = currentController
        self.skipBackward = skipBackward
        self.skipForward = skipForward

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        setViewControllers([currentController], direction: .forward, animated: false)
    }
}

// MARK: - UIPageViewControllerDataSource

extension SwipeTrackPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        previousController
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        nextController
    }
}

// MARK: - UIPageViewControllerDelegate

extension SwipeTrackPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingViewController = pendingViewControllers.first
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if finished, completed {
            switch pendingViewController {
            case previousController:
                skipBackward()
            case nextController:
                skipForward()
            default:
                break
            }
        }
    }
}
