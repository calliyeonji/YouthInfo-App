//
//  RoundUIImageView.swift
//  YouthInfoApp
//
//  Created by yeonji on 2023/01/09.
//

import Foundation
import UIKit
//인터페이스 빌더에서 디자인으로 확인 가능하도록
@IBDesignable
class RoundUIImageView : UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
