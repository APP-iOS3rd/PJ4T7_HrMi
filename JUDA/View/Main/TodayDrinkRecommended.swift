//
//  TodayDrinkRecommended.swift
//  JUDA
//
//  Created by 백대홍 on 1/31/24.
//

import SwiftUI

// MARK: - 오늘의 추천 술 데이터
struct TodayDrink: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let image: String
}

let TodayDrinkData: [TodayDrink] = [
    TodayDrink(title: "지평 막걸리", image:"jipyeong"),
    TodayDrink(title: "루나가이아 지비뽀", image:"jibibbo"),
    TodayDrink(title: "진로", image:"jinro"),
]

// MARK: - 오늘의 추천 술 이미지 + 이름
struct TodayDrinkRecommended: View {
<<<<<<< HEAD
    @Binding var isLoggedIn: Bool
=======
    @EnvironmentObject private var authService: AuthService

>>>>>>> 25c0a42 ([Feat] AppleLogin 작성 중 #104)
    let todayDrink: [TodayDrink] = TodayDrinkData
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                ForEach(todayDrink, id: \.self) { drink in
<<<<<<< HEAD
                    if isLoggedIn {
=======
                    if authService.signInStatus {
>>>>>>> 25c0a42 ([Feat] AppleLogin 작성 중 #104)
                        // TODO: NavigationLink - value 로 수정
                        NavigationLink {
                            DrinkDetailView(drink: Wine.wineSample01) // 임시 더미데이터
                                .modifier(TabBarHidden())
                        } label: {
                            TodayDrinkRecommendedCell(todayDrink: drink)
                        }
                    } else {
                        TodayDrinkRecommendedCell(todayDrink: drink)
                    }
                }
            }
        }
    }
}

#Preview {
    TodayDrinkRecommended()
}

// MARK: - 오늘의 추천 술 셀
struct TodayDrinkRecommendedCell: View {
    let todayDrink: TodayDrink
    
    var body: some View {
        VStack {
            // 이미지
            Image(todayDrink.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 103.48)
                .padding(.bottom, 10)
            // 술 이름
            Text(todayDrink.title)
                .font(.regular12)
                .foregroundStyle(.mainBlack)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TodayDrinkRecommendedCell(todayDrink: TodayDrink(title: "지평 막걸리", image:"jipyeong"))
}
