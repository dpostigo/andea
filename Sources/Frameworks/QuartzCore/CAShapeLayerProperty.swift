//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

public enum CAShapeLayerProperty: RawRepresentable, ParameterRepresentable, Titled {
    case lineWidth(CGFloat)
    case miterLimit(CGFloat)
    case lineCap(CAShapeLayer.LineCapStyle)
    case lineJoin(CAShapeLayer.LineJoinStyle)
    
    public init?(rawValue: Int) {
        guard let name = Name(rawValue: rawValue) else { return nil }
        switch name {
            case .lineWidth: self = .lineWidth(0)
            case .miterLimit: self = .miterLimit(0)
            case .lineCap: self = .lineCap(CAShapeLayer.LineCapStyle(0)!)
            case .lineJoin: self = .lineJoin(CAShapeLayer.LineJoinStyle(0)!)
        }
    }
    
    public var rawValue: Int { return self.name.rawValue }
}



extension CAShapeLayer {
    public enum LineCapStyle: Int, Autorepresentable {
        case butt
        case round
        case square
    }
    
    public var lineCapStyle: CAShapeLayer.LineCapStyle? {
        return CAShapeLayer.LineCapStyle(stringValue: self.lineCap)
    }
   
    public enum LineJoinStyle: Int, Autorepresentable {
        case miter
        case round
        case bevel
        
        public var stringValue: String {
            switch self {
                case .miter: return kCALineJoinMiter
                case .round: return kCALineJoinRound
                case .bevel: return kCALineJoinBevel
            }
        }
    }
    
    public var lineJoinStyle: CAShapeLayer.LineJoinStyle? {
        return CAShapeLayer.LineJoinStyle(stringValue: self.lineJoin)
    }
}


extension CAShapeLayer {
    
    public var shapeLayerProperty: CAShapeLayerProperty? {
        get { return nil }
        set { newValue.some { self.update(style: $0) } }
    }
    
    private func update(style: CAShapeLayerProperty) {
        switch style {
            case .lineWidth(let value): self.lineWidth = value
            case .miterLimit(let value): self.miterLimit = value
            case .lineCap(let value): self.lineCap = value.stringValue
            case .lineJoin(let value) : self.lineJoin = value.stringValue
        }
    }
}

extension CAShapeLayerProperty {
    public var title: String {
        switch self {
            case .lineWidth: return "Line Width"
            case .miterLimit: return "Miter Limit"
            case .lineCap: return "Line Cap"
            case .lineJoin: return "Line Join"
        }
    }
    
    public var value: Any {
        switch self {
            case .lineWidth(let value): return value
            case .miterLimit(let value): return value
            case .lineCap(let value): return value
            case .lineJoin(let value): return value
        }
    }
    
    public enum Name: Int, Autorepresentable {
        case lineWidth
        case miterLimit
        case lineCap
        case lineJoin
    }
    
    public var name: Name {
        return Name(stringValue: Mirror.customReflect(self))!
    }
    
}
