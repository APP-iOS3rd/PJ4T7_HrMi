//
//  DrinkInfoGrid.swift
//  FinalHrmiProjects
//
//  Created by phang on 1/28/24.
//

import SwiftUI

struct DrinkInfoGrid: View {
    
    var body: some View {
        // MARK: iOS 16.4 이상
        if #available(iOS 16.4, *) {
            ScrollView() {
                DrinkGridContent()
            }
            .scrollBounceBehavior(.basedOnSize, axes: .vertical)
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
        // MARK: iOS 16.4 미만
        } else {
            ViewThatFits(in: .vertical) {
                DrinkGridContent()
                    .frame(maxHeight: .infinity, alignment: .top)
                ScrollView {
                    DrinkGridContent()
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
            }
        }
    }
}

struct DrinkGridContent: View {
    // 술 그리드 셀 2개 column
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        // 그리드
        LazyVGrid(columns: columns, spacing: 10) {
            // TODO: 현재 더미데이터 10개를 보여주지만, 데이터 들어온 리스트로 ForEach 돌릴 예정
            ForEach(0..<10, id: \.self) { _ in
                // TODO: 추후에 네비게이션으로 해당 술의 Detail 로 이동 연결
                NavigationLink {
                    DrinkDetailView()
                        .modifier(TabBarHidden())
                } label: {
                    DrinkGridCell()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    DrinkInfoGrid()
}
