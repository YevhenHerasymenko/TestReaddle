//
//  ContentView.swift
//  TestReaddle
//
//  Created by Yevhen Herasymenko on 11.04.2024.
//

import SwiftUI

struct ContentView: View {

    @State var counter: Int = 1

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
                rowContent(count: counter)
            }
        }
        .background(.gray)

    }

    @ViewBuilder
    func rowContent(count: Int) -> some View {
        ScrollView(.horizontal) {
            ScrollViewReader { value in
                HStack(spacing: 20) {
                    ForEach(0..<count, id: \.self) { i in
                        Color.red
                            .frame(width: 100, height: 100)
                    }
                    .onChange(of: count) { oldValue, newValue in
                        withAnimation(Animation.linear(duration: 2)) {
                            value.scrollTo(count - 1)
                        }
                    }
                }
            }
        }
        .frame(height: 150)
    }

    @ViewBuilder
    var actionButton: some View {
        Button(
            action: {
                counter += 1
            },
            label: {
            Text("Add element")
        })
    }
}

#Preview {
    ContentView()
}
