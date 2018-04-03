//
// Created by Daniela Postigo on 4/1/18.
//

import Foundation

public protocol NotificationType: Autorepresentable {
    var notification: Notification { get }
}

extension NotificationType {
    public var notification: Notification {
        return Notification.init(name: Notification.Name(self.stringValue))
    }
}

extension NotificationCenter {
    public func addObserver<T: NotificationType>(_ observer: Any, selector aSelector: Selector, notificationType: T, object anObject: Any? = nil) {
        self.addObserver(observer, selector: aSelector, name: notificationType.notification.name, object: anObject)
    }
    
    public func post<T: NotificationType>(_ notificationType: T) {
        self.post(notificationType.notification)
    }
}

extension Notification {
    
    func notificationType<T: NotificationType>(_ notificationType: T.Type = T.self) -> T {
        return notificationType.init(stringValue: self.name.rawValue)!
    }
}
