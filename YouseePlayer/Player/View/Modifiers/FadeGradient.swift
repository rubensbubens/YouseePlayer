//
//  FadeGradient.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import SwiftUI

public extension View {
    func fadeGradient(_ alignment: [Alignment],
                      length: CGFloat) -> some View {
        self.mask(FadeGradient(alignment: alignment,
                               length: length))
    }

    func fadeGradient(_ alignment: Alignment,
                      length: CGFloat) -> some View {
        self.mask(FadeGradient(alignment: [alignment],
                               length: length))
    }
}

private struct FadeGradient: View {
    let alignment: [Alignment]
    let length: CGFloat

    let gradient = Gradient(colors: [.clear, .black])

    func linearGradient(for alignment: Alignment) -> LinearGradient {
        if alignment == .leading {
            return LinearGradient(gradient: gradient,
                                  startPoint: .leading,
                                  endPoint: .trailing)
        }

        if alignment == .top {
            return LinearGradient(gradient: gradient,
                                  startPoint: .top,
                                  endPoint: .bottom)
        }

        if alignment == .trailing {
            return LinearGradient(gradient: gradient,
                                  startPoint: .trailing,
                                  endPoint: .leading)
        }

        if alignment == .bottom {
            return LinearGradient(gradient: gradient,
                                  startPoint: .bottom,
                                  endPoint: .top)
        }

        fatalError("Unsupported gradient alignment: \(alignment).")
    }

    @ViewBuilder
    var body: some View {
        if alignment.contains(.leading) || alignment.contains(.trailing) {
            HStack(spacing: 0) {
                if alignment.contains(.leading) {
                    self.linearGradient(for: .leading)
                        .frame(width: length)
                }
                Rectangle()
                    .background(Color.clear)
                if alignment.contains(.trailing) {
                    self.linearGradient(for: .trailing)
                        .frame(width: length)
                }
            }
        }
        if alignment.contains(.top) || alignment.contains(.bottom) {
            VStack(spacing: 0) {
                if alignment.contains(.top) {
                    self.linearGradient(for: .top)
                        .frame(height: length)
                }
                Rectangle()
                    .background(Color.clear)
                if alignment.contains(.bottom) {
                    self.linearGradient(for: .bottom)
                        .frame(height: length)
                }
            }
        }
    }
}
