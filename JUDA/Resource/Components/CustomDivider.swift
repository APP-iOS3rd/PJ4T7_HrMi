//
//  CustomDivider.swift
//  JUDA
//
//  Created by phang on 1/26/24.
//

import SwiftUI

// MARK: - 디바이더
struct CustomDivider: View {
    var body: some View {
        Divider()
            .frame(height: 0.5)
            .backgroundStyle(.gray04)
    }
}

#Preview {
    CustomDivider()
}
