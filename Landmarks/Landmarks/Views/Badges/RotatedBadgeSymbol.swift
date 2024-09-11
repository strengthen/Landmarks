//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

// 创建一个新的 RotatedBadgeSymbol 视图来封装旋转符号的概念。
struct RotatedBadgeSymbol: View {
    let angle: Angle

    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

#Preview {
    // 在预览中调整角度来测试旋转的效果。
    RotatedBadgeSymbol(angle: Angle(degrees: 5))
}
