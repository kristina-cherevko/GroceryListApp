//
//  UIColorExtension.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/25/25.
//

import UIKit

extension UIColor {
    static let amber: UIColor = UIColor(hexString: "#FFB300")!
    static let crayola: UIColor = UIColor(hexString: "#2F5BA5")!
    static let kellyGreen: UIColor = UIColor(hexString: "#3FBD00")!
    
    public convenience init?(hexString: String?, transparency: CGFloat = 1) {
        guard let hexString = hexString else { return nil }
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var alpha = transparency
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        
        let red = CGFloat((hexValue >> 16) & 0xff) / 255.0
        let green = CGFloat((hexValue >> 8) & 0xff) / 255.0
        let blue = CGFloat(hexValue & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func toHex() -> String? {
        guard let components = self.cgColor.components else { return nil }
        let r = components[0]
        let g = components[1]
        let b = components.count > 2 ? components[2] : components[0]
        
        let hex = String(
            format: "#%02X%02X%02X",
            Int(r * 255),
            Int(g * 255),
            Int(b * 255)
        )
        
        return hex
    }
}
