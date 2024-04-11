//
//  ContentView.swift
//  TestReaddle
//
//  Created by Yevhen Herasymenko on 11.04.2024.
//

import SwiftUI

public protocol MyView {
    init()
    func add()
    func removeElement(at index: Int)
}

struct ContentView: View, MyView {

    @State private var array: [Int] = []

    @State private var offset: CGFloat = 0
    @State private var dragElement: Int?

    public init() {}

    public func add() {
        DispatchQueue.main.async {
            self.addElement()
        }
    }

    public func removeElement(at index: Int) {
        DispatchQueue.main.async {
            self.removeElement(at: index)
        }
    }

    private func addElement() {
        let last = array.last ?? -1
        array.append(last + 1)
    }

    private func remove(at index: Int) {
        guard array.count > index, index >= 0 else { return }
        array.remove(at: index)
    }

    var body: some View {
        VStack(spacing: 50) {
            contentView
            actionButton
        }
    }

    @ViewBuilder
    var contentView: some View {
        Grid(alignment: .center, verticalSpacing: 10) {
            GridRow {
                rowContent
            }
        }
        .background(.gray)

    }

    @ViewBuilder
    var rowContent: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { value in
                HStack(spacing: 20) {
                    ForEach(array, id: \.self) { element in
                        cell(for: element)
                    }
                    .onChange(of: array) { oldValue, newValue in
                        if newValue.count > oldValue.count, let last = array.last {
                            withAnimation(Animation.linear(duration: 2)) {
                                value.scrollTo(last)
                            }
                        }
                    }
                }
                .padding(40)
            }
        }
        .animation(.spring(), value: array)
        .frame(height: 150)
    }

    @ViewBuilder
    func cell(for element: Int) -> some View {
        Color.red
            .frame(width: 100, height: 100)
            .onTapGesture {
                array.removeAll { $0 == element }
            }
            .offset(y: dragElement == element ? offset : 0)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        dragElement = element
                        offset = gesture.translation.height
                    }
                    .onEnded { _ in
                        if abs(offset) > 50 {
                            array.removeAll { $0 == element }
                        } else {
                            offset = .zero
                        }
                        offset = .zero
                        dragElement = nil
                    }
            )
    }

    @ViewBuilder
    var actionButton: some View {
        Button(
            action: {
                addElement()
            },
            label: {
            Text("Add element")
        })
    }
}

#Preview {
    ContentView()
}
