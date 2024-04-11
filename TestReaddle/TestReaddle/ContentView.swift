//
//  ContentView.swift
//  TestReaddle
//
//  Created by Yevhen Herasymenko on 11.04.2024.
//

import SwiftUI

//struct Item {
//    let id = UUID()
//}

struct ContentView: View {

    @State var array: [Int] = (0..<10).map { $0 }
    @State var deletingIndex: Int = -1

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
                        withAnimation(Animation.linear(duration: 2)) {
                            value.scrollTo(array.count - 1)
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
                guard let last = array.last else { return }
                array.append(last + 1)
            },
            label: {
            Text("Add element")
        })
    }
}

#Preview {
    ContentView()
}
