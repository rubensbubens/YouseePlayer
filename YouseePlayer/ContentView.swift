//
//  ContentView.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 20.10.22.
//

import SwiftUI

struct ContentView: View {
//    @State var page: TrackPage = .current
//
//    var body: some View {
//        ScrollView {
//            LazyHStack {
//                PageView(selection: $page)
//            }
//            .onChange(of: page) { newValue in
//                if newValue != .current {
//                    page = .current
//                }
//            }
//        }
//    }
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount.width = $0.translation.width }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        dragAmount = .zero
                    }
                    enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum TrackPage: Hashable, CaseIterable {
    case previous
    case current
    case next

    var readable: String {
        switch self {
        case .previous:
            return "Previous"
        case .current:
            return "Current"
        case .next:
            return "Next"
        }
    }
}

struct PageView: View {
    @Binding var selection: TrackPage

    var body: some View {
        TabView(selection: $selection) {
            ForEach(TrackPage.allCases, id: \.self) { page in
                ZStack {
                    Color.black
                    Text("\(page.readable)")
                        .foregroundColor(.white)
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 10.0,
                        style: .continuous
                    )
                )
            }
            .padding(.all, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
