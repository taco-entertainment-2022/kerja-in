//
//  CustomFont.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 09/10/22.
//

import UIKit

extension UIFont {

    public enum OutfitType: String {
        case black = "-Black"
        case bold = "-Bold"
        case extraBold = "-ExtraBold"
        case extraLight = "-ExtraLight"
        case light = "-Light"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiBold = "-SemiBold"
        case thin = "-Thin"
    }

    static func Outfit(_ type: OutfitType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Outfit\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}

