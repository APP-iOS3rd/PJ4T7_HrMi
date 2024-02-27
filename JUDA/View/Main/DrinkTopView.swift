//
//  DrinkTopView.swift
//  JUDA
//
//  Created by 백대홍 on 2/25/24.
//

import SwiftUI

struct DrinkTopView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @EnvironmentObject private var authService: AuthService
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .lastTextBaseline) {
                Text("인기 술")
                    .font(.semibold20)
                
                Spacer()
                
                Button {
                    selectedTabIndex = 1
                } label: {
                    Text("더보기")
                        .foregroundStyle(.gray01)
                        .font(.semibold16)
                }
            }
            .padding(20)
            
            ForEach(mainViewModel.drinks, id:\.drinkID) { drink in
                NavigationLink(value: Route
                    .DrinkDetailWithUsedTo(drink: drink,
                                           usedTo: .main)) {
                    DrinkListCell(drink: drink,
                                  isLiked: authService.likedDrinks.contains{ $0 == drink.drinkID },
                                  usedTo: .main)
                }
            }
        }
    }
}

