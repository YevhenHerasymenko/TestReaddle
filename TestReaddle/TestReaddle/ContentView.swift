//
//  ContentView.swift
//  TestReaddle
//
//  Created by Yevhen Herasymenko on 11.04.2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            contentView
        }
//        .padding()
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
            HStack(spacing: 20) {
                ForEach(0..<10) { _ in
                    Color.red
                        .frame(width: 100, height: 100)
                }
            }
        }
        .frame(height: 150)
    }
}

#Preview {
    ContentView()
}
