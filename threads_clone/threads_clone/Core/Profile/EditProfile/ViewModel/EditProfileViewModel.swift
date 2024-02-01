//
//  EditProfileViewModel.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    
    // ユーザーが選択した画像
    @Published var selectedItem: PhotosPickerItem? {
        // 値が変更されると、loadImage()メソッドが非同期で呼び出されます
        didSet { Task { await loadImage() } }
    }
    // 選択された画像をUIに表示するために使用
    @Published var profileImage: Image?

    // 画像をアップロードするために使用
    // UIImage : 画像をメモリにロードし、それを描画するために使用
    // UIImageオブジェクト : 画像のスケールや方向などのデータをカプセル化する
    private var uiImage: UIImage?
    
    func updateUserData() async throws {
        try await updateProfileImage()
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }
        // 選択された画像（item）をData型としてロード
        guard let data = try? await item
            // 画像データを指定した型のデータ (バイナリデータ) をロード
            .loadTransferable(type: Data.self) else { return }
        // ロードした画像データ（data）をUIImageオブジェクトに変換
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        // URLをUserServiceを通じてユーザープロフィールに設定
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
}
