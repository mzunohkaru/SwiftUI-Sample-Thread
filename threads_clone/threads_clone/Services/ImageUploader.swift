//
//  ImageUploader.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageUploader {
    // static関数 : インスタンスを作成せずに直接呼び出すことができます
    static func uploadImage(_ image: UIImage) async throws -> String? {
        // 画像をJPEG形式のデータに変換
        // compressionQuality : 圧縮
        guard let imageData = image.jpegData(compressionQuality: 0.25) else { return nil }
        // 保存するファイル名を一意のものに指定
        let filename = NSUUID().uuidString
        // アップロードする画像の保存先を指定
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            // データをFirebase Storageにアップロード
            let _ = try await storageRef.putDataAsync(imageData)
            // アップロードした画像のURLを取得
            let url = try await storageRef.downloadURL()
            // 取得したURLの絶対文字列
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
