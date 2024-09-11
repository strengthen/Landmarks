//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

//向 WatchLandmarks Watch App 文件夹中添加一个名为 LandmarkList.swift 的新 SwiftUI 视图，该视图仅针对 WatchLandmarks Watch App，并删除旧文件的 WatchLandmarks Watch App 目标成员资格。
struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
