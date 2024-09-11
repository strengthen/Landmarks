//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            // 在 BadgeBackground 中，向徽章添加路径形状并应用 fill() 修饰符将形状变成视图。
            // 您可以使用路径组合线条、曲线和其他绘图图元来形成更复杂的形状，如徽章的六边形背景。
            Path { path in
                // 向路径添加一个起点，假设容器的尺寸为 100 x 100 像素。
                // 将路径包装在 GeometryReader 中，以便徽章可以使用其包含视图的大小，该视图定义大小而不是硬编码值（100）。
                // 当徽章的包含视图不是正方形时，使用几何体的两个维度中最小的一个可以保持徽章的纵横比。
                var width = min(geometry.size.width, geometry.size.height)
                let height = width
                // 使用 xScale 在 x 轴上缩放形状，然后添加 xOffset 以使形状在其几何图形内重新居中。
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                // move（to:) 方法将绘图光标移动到形状的边界内，就好像一支假想的笔或铅笔悬停在该区域上，等待开始绘图。
                path.move(
                    to: CGPoint(
                        // 使用 xScale 在 x 轴上缩放形状，然后添加 xOffset 以使形状在其几何图形内重新居中。
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                // 为形状数据的每个点绘制线条以创建粗略的六边形。
                HexagonParameters.segments.forEach { segment in
                    // addLine(to:) 方法接受一个点并绘制它。连续调用 addLine(to:) 将从上一个点开始绘制一条线，并继续绘制到新点。
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    // 使用 addQuadCurve（to：control:) 方法为徽章的角落绘制贝塞尔曲线。
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            // 在 BadgeBackground 中，向徽章添加路径形状并应用 fill() 修饰符将形状变成视图。
            .fill(.linearGradient(
                // 用渐变替换纯黑色背景以匹配设计。
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        // 将aspectRatio（_：contentMode：）修饰符应用于渐变填充。
        // 通过保持 1：1 的宽高比，即使徽章的祖先视图不是正方形，它也能保持在视图的中心位置。
        .aspectRatio(1, contentMode: .fit)
    }
    // 用渐变替换纯黑色背景以匹配设计。
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

#Preview {
    BadgeBackground()
}
