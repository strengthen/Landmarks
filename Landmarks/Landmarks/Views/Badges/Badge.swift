//
//  Badge.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

struct Badge: View {
    // 将徽章符号放置在 ZStack 中，覆盖在徽章背景上。
    var badgeSymbols: some View {
        // 添加 ForEach 视图来旋转并显示徽章符号的副本。
        // 完整的 360° 旋转分为八个部分，通过重复山形符号形成类似太阳的图案。
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360.0
            )
        }
        .opacity(0.5)
    }

    var body: some View {
        ZStack {
            // 将 BadgeBackground 放置在 Badge 的主体中。
            BadgeBackground()

            // 通过读取周围的几何形状并缩放符号来纠正徽章符号的大小。
            GeometryReader { geometry in
                // 将徽章符号放置在 ZStack 中，覆盖在徽章背景上。
                badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

#Preview {
    Badge()
}
