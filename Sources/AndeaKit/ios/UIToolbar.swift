//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

public enum UIToolbarStyle: Int, Autorepresentable {
    case normal
    case dark
    
    var components: [Components] {
        switch self {
            case .normal: return [.solid, .foreground(nil), .background(nil)]
            case .dark: return [.translucent, .foreground(.white), .background(.black)]
        }
    }
    enum Components {
        case solid
        case translucent
        case foreground(UIColor?)
        case background(UIColor?)
    }
}

extension UIToolbar {
    
    public var toolbarStyle: UIToolbarStyle? {
        get { return nil }
        set { self.update(toolbarStyle: newValue) }
    }
    
    private func update(toolbarStyle: UIToolbarStyle?) {
        guard let toolbarStyle = toolbarStyle else { return }
        toolbarStyle.components.forEach {
            switch $0 {
                case .foreground(let value): self.tintColor = value
                case .background(let value): self.barTintColor = value
                case .translucent: self.isTranslucent = true
                case .solid: self.isTranslucent = false
            }
        }
    }
    
}
