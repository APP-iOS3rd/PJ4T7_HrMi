//
//  CustomDialog.swift
//  FinalHrmiProjects
//
//  Created by 정인선 on 2/1/24.
//

import SwiftUI

// MARK: - 커스텀 다이얼로그 타입
enum CustomDialogType {
    case oneButton(message: String,
                   buttonLabel: String, action: () -> Void)
    case twoButton(message: String,
                   leftButtonLabel: String, leftButtonAction: () -> Void,
                   rightButtonLabel: String, rightButtonAction: () -> Void)
    case rating(drinkName: String,
                leftButtonLabel: String, leftButtonAction: () -> Void,
                rightButtonLabel: String, rightButtonAction: () -> Void,
                rating: Binding<Double>)
}

// MARK: - 커스텀 다이얼로그
struct CustomDialog: View {
    let type: CustomDialogType
    
    var body: some View {
        ZStack {
            Color.gray01
                .opacity(0.4)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                // MARK: - 타입에 따라, ViewBuilder 사용해서 각자 뷰 보여주기
                switch type {
                case let .oneButton(message, buttonLabel, action):
                    buildOneButtonDialog(message: message, buttonLabel: buttonLabel, action: action)
                case let .twoButton(message, leftButtonLabel, leftButtonAction, rightButtonLabel, rightButtonAction):
                    buildTwoButtonDialog(message: message,
                                         leftButtonLabel: leftButtonLabel, leftButtonAction: leftButtonAction,
                                         rightButtonLabel: rightButtonLabel, rightButtonAction: rightButtonAction)
                case let .rating(drinkName, leftButtonLabel, leftButtonAction, rightButtonLabel, rightButtonAction, rating):
                    buildRatingDialog(drinkName: drinkName,
                                      leftButtonLabel: leftButtonLabel, leftButtonAction: leftButtonAction,
                                      rightButtonLabel: rightButtonLabel, rightButtonAction: rightButtonAction,
                                      rating: rating)
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            .frame(width: 270)
            .background(.background)
            .cornerRadius(10)
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - 버튼 하나만 있는 다이얼로그
    @ViewBuilder
    private func buildOneButtonDialog(message: String,
                                      buttonLabel: String,
                                      action: @escaping () -> Void) -> some View {
        Group {
            Text(message)
                .font(.medium16)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
            
            CustomDivider()
            
            Button {
                action()
            } label: {
                Text(buttonLabel)
                    .font(.medium16)
                    .foregroundStyle(.gray01)
            }
        }
    }
    
    // MARK: - 버튼 두개 있는 다이얼로그 (왼쪽 버튼 gray01, 오른쪽 버튼 mainAccent03)
    @ViewBuilder
    private func buildTwoButtonDialog(message: String,
                                      leftButtonLabel: String, leftButtonAction: @escaping () -> Void,
                                      rightButtonLabel: String, rightButtonAction: @escaping () -> Void) -> some View {
        Group {
            Text(message)
                .font(.medium16)
                .multilineTextAlignment(.center)
                .lineSpacing(10)
            
            CustomDivider()
            
            HStack(spacing: 0) {
                Button {
                    leftButtonAction()
                } label: {
                    Text(leftButtonLabel)
                        .font(.medium16)
                        .foregroundColor(.gray01)
                }
                .frame(width: 115)

                Button {
                    rightButtonAction()
                } label: {
                    Text(rightButtonLabel)
                        .font(.medium16)
                        .foregroundColor(.mainAccent03)
                }
                .frame(width: 115)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - 버튼 두개 + 별점 체크 다이얼로그 (왼쪽 버튼 gray01, 오른쪽 버튼 mainAccent03)
    @ViewBuilder
    private func buildRatingDialog(drinkName: String,
                                   leftButtonLabel: String, leftButtonAction: @escaping () -> Void,
                                   rightButtonLabel: String, rightButtonAction: @escaping () -> Void,
                                   rating: Binding<Double>) -> some View {
        Group {
            Text(drinkName)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
                .font(.medium18)
            
            // MARK: 별점 매기는 부분
            HStack(spacing: 0) {
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .font(.system(size: 32))
                    // 선택된 이미지까지 색 변경
                        .foregroundStyle(Double(number) > rating.wrappedValue ? .gray01 : .mainAccent03)
                        .onTapGesture {
                            // 첫번째 별만 채워져 있을 때, 한 번 더 탭하면 0점이 됨
                            if rating.wrappedValue == 1 && number == 1 {
                                rating.wrappedValue = 0
                            } else {
                                // 선택된 별의 개수만큼 점수를 바꿔줌
                                rating.wrappedValue = Double(number)
                            }
                        }
                }
            }
            
            CustomDivider()
            
            HStack(spacing: 0) {
                Button {
                    leftButtonAction()
                } label: {
                    Text(leftButtonLabel)
                        .font(.medium16)
                        .foregroundColor(.gray01)
                }
                .frame(width: 115)
                
                Button {
                    rightButtonAction()
                } label: {
                    Text(rightButtonLabel)
                        .font(.medium16)
                        .foregroundColor(.mainAccent03)
                }
                .frame(width: 115)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CustomDialog( type: .rating(
        drinkName: "술 이름",
        leftButtonLabel: "취소",
        leftButtonAction: {},
        rightButtonLabel: "평가",
        rightButtonAction: {},
        rating: .constant(0))
    )
}
