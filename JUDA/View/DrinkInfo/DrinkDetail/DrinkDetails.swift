//
//  DrinkDetails.swift
//  JUDA
//
//  Created by phang on 1/30/24.
//

import SwiftUI
import Kingfisher

// MARK: - 술 디테일에서 보여주는 상단의 술 정보 부분 (이미지, 이름, 가격 등)
struct DrinkDetails: View {
    @StateObject private var drinkImageViewModel = DrinkImageViewModel()
    let drink: FBDrink

    var body: some View {
        // 술 정보 (이미지, 이름, 용량, 나라, 도수, 가격, 별점, 태그된 게시물)
        HStack(alignment: .center, spacing: 30) {
            // 술 이미지
            if drinkImageViewModel.isLoading {
                KFImage(URL(string: drinkImageViewModel.imageString))
                    .placeholder {
                        CircularLoaderView(size: 20)
                            .frame(height: 180)
                            .padding(10)
                            .frame(width: 100)
                    }
                    .loadDiskFileSynchronously(true) // 디스크에서 동기적으로 이미지 가져오기
                    .cacheMemoryOnly() // 메모리 캐시만 사용 (디스크 X)
                    .fade(duration: 0.2) // 이미지 부드럽게 띄우기
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .padding(10)
                    .frame(width: 100)
            } else {
                Text("No Image")
                    .font(.medium16)
                    .foregroundStyle(.mainBlack)
                    .frame(height: 180)
                    .padding(10)
                    .frame(width: 100)
            }
            // 이름, 나라, 도수, 가격, 별점, 태그된 게시물
            VStack(alignment: .leading, spacing: 6) {
                // 이름 + 용량
                Text(drink.name + " " + drink.amount)
                    .font(.semibold18)
                    .foregroundStyle(.mainBlack)
                    .lineLimit(2)
                // 종류, 도수
                HStack {
                    // 종류
                    Text(drink.type)
                    // 도수
                    Text(Formatter.formattedABVCount(abv: drink.alcohol))
                }
                // 나라, 지방
                HStack {
                    // 나라
                    Text(drink.country)
                    if drink.category == DrinkType.wine.rawValue, 
                        let province = drink.province {
                        Text(province) // 지방
                    }
                }
                .font(.regular16)
                // 가격
                Text(Formatter.formattedPriceToString(price: drink.price))
                    .font(.regular16)
                // 별점
                StarRating(rating: drink.rating, color: .mainAccent05,
                           starSize: .regular16, fontSize: .regular16, starRatingType: .withText)
                // 태그된 게시물
                // TODO: NavigationLink - value 로 수정
                NavigationLink {
					NavigationPostsView()
                } label: {
                    Text("\(drink.taggedPostID.count)개의 태그된 게시물")
                        .font(.regular16)
                        .foregroundStyle(.gray01)
                        .underline()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        // 이미지 불러오기
        .task {
            await drinkImageViewModel
                .getImageURLString(category: DrinkType(rawValue: drink.category) ?? DrinkType.all,
                                   detailedCategory: drink.type)
        }
    }
}
