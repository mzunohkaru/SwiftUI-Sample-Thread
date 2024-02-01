//
//  String.swift
//  threads_clone
//
//  Created by Mizuno Hikaru on 2024/02/01.
//

import UIKit

extension String {
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        // テキストが与えられた幅内でどれだけの高さを必要とするかを計算するために使用
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        // テキストが占める矩形のサイズを計算
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
                                            
        // 計算された矩形の高さを切り上げます
        return ceil(boundingBox.height)
    }
}
