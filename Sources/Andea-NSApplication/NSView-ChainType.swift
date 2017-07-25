//
// Created by Daniela Postigo on 7/22/17.
//

import Foundation
import AppKit

public enum ChainType {
    case keyViews
    case responders

    var title: String {
        switch self {
            case .keyViews: return "Key Views"
            case .responders: return "Responders"
        }
    }

    func string(_ view: NSView) -> String {
        return view.subviewListString(self.closure)
    }

    // MARK: Closures

    var closure: ((NSView) -> [String]) {
        switch self {
            case .keyViews:
                return { view in
                    return [
                            "- \(String(describing: view))",
                            "nextKeyView: \(String(describing: view.nextKeyView))".whitespace(5),
                            "nextValidKeyView: \(String(describing: view.nextValidKeyView))".whitespace(5)
                    ]
                }

            case .responders :
                return { view in
                    return ["- \(String(describing: view))",
                            "nextResponder: \(String(describing: view.nextResponder))".whitespace(5),
                    ]
                }
        }
    }

    public func responderChain(_ responder: NSResponder, _ closure: (NSResponder) -> String) -> String {
        var responder: NSResponder = responder
        var string = closure(responder)

        while let next = responder.nextResponder {
            string += closure(next)
            responder = next
        }
        return string
    }
}

extension NSView {


    public func debug(title: String, string: String) {
        Swift.print("\n\(title):\n\(string) ")
    }

    public func debug(_ chain: ChainType) {
        self.debug(title: chain.title, string: chain.string(self))
    }


    public func subviewListString(_ closure: (NSView) -> [String]) -> String {
        return self.subviewString({ return closure($0).newLines })
    }

    public func subviewString(_ closure: (NSView) -> String) -> String {
        var string = closure(self)
        guard !self.subviews.isEmpty else { return string }
        let subviewString = self.subviews.map({ $0.subviewString(closure) })
        return "\(string)\n\(subviewString.whitespace(3))"
    }


}

extension ChainType {


}