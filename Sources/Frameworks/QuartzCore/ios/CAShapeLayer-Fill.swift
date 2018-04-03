//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

extension CAShapeLayer {
    
    public enum FillRule: Int, Autorepresentable {
        case nonZero
        case evenOdd
        
        public var stringValue: String {
            switch self {
                case .nonZero: return kCAFillRuleNonZero
                case .evenOdd: return kCAFillRuleEvenOdd
            }
        }
    }
    
    // MARK: Fill
    
    public enum FillType {
        case color(Color)
        case rule(FillRule, Color?)
        case evenOdd(Color?)
    }

#if os(iOS)
    
    // MARK: CAShapeLayer.Fill
    
    public convenience init(fill: FillType) {
        self.init(); self.fillType = fill
    }
    
    public var fillType: FillType? {
        get { return nil }
        set { self.update(fill: newValue) }
    }
    
    
    // MARK: Private
    
    private func update(fill: FillType?) {
        guard let fill = fill else { return }
        switch fill {
            case .color(let value):
                self.fillColor = value.cgColor
            case .rule(let rule, let color):
                self.fillRule = rule.stringValue
                self.fillColor = color?.cgColor
            case .evenOdd(let color): self.update(fill: .rule(.evenOdd, color))
        }
    }

#endif
    
}


