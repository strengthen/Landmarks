//
//  HexagonParameters.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import CoreGraphics

struct HexagonParameters {
    // 定义一个 Segment 结构来保存代表六边形一侧的三个点；导入 CoreGraphics 以便可以使用 CGPoint。
    // 每条边从前一条边的结束处开始，沿直线移动到第一个点，然后沿拐角处的贝塞尔曲线移动到第二个点。第三个点控制曲线的形状。
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }

    static let adjustment: CGFloat = 0.085
    // 创建一个数组来保存段。
    static let segments = [
        // 添加六个线段的数据，六边形的每一边一个线段。
        // 这些值以单位正方形的分数形式存储，单位正方形的原点位于左上角，x 正值位于右侧，y 正值位于下方。稍后，您将使用这些分数来查找具有给定大小的六边形的实际点。
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        // 添加调整值，可调整六边形的形状。
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        // 添加调整值，可调整六边形的形状。
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        // 添加调整值，可调整六边形的形状。
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        // 添加调整值，可调整六边形的形状。
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
}
