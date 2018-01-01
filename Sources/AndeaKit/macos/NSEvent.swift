//
// Created by Daniela Postigo on 7/20/17.
//

import Foundation

public enum KeyCharacter: String {
    case newLine = "\r"
    case tab = "\t"


    public init?(characters: String?) {
        guard let characters = characters else { return nil }
        self.init(rawValue: characters)
    }

    public init?(event: NSEvent) {
        self.init(characters: event.characters)
    }
}
