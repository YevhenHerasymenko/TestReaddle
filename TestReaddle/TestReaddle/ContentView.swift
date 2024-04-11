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
                        Color.red
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                array.removeAll { $0 == element }
                            }
                    }
                    .onChange(of: array) { oldValue, newValue in
                        if newValue.count > oldValue.count, let last = array.last {
                            withAnimation(Animation.linear(duration: 2)) {
                                value.scrollTo(last)
                            }
                        }
                    }
                }
            }
        }
        .animation(.spring(), value: array)
        .frame(height: 150)
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
