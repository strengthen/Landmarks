//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

struct FavoriteButton: View {
    // 添加一个 isSet 绑定来指示按钮的当前状态，并为预览提供一个常量值。
    // 绑定属性包装器可让您在存储数据的属性和显示和更改数据的视图之间进行读写。由于您使用绑定，因此在此视图内所做的更改会传播回数据源。
    @Binding var isSet: Bool

    var body: some View {
        // 创建一个按钮，该按钮具有切换 isSet 状态的操作，并且可以根据状态改变其外观。
        Button{
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly) // 当您使用 iconOnly 标签样式时，您为按钮标签提供的标题字符串不会出现在 UI 中，但 VoiceOver 会使用它来提高可访问性。
                .foregroundStyle(isSet ? .yellow : .gray)
        }
    }
}


#Preview {
    FavoriteButton(isSet: .constant(true))
}
