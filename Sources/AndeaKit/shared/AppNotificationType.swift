//
// Created by Daniela Postigo on 4/2/18.
//

import Foundation

public enum AppNotificationType: Int, Autorepresentable, NotificationType {
    case login
    case logout
}


extension NotificationCenter {
    open func addObserver(_ observer: Any, selector aSelector: Selector, notificationTypes: AppNotificationType...) {
        notificationTypes.forEach { self.addObserver(observer, selector: aSelector, appNotificationType: $0) }
    }
    
    open func addObserver(_ observer: Any, selector aSelector: Selector, appNotificationType: AppNotificationType, object anObject: Any? = nil) {
        self.addObserver(observer, selector: aSelector, name: appNotificationType.notification.name, object: anObject)
    }
    
    open func post(_ notificationType: AppNotificationType) {
        self.post(notificationType.notification)
    }
}

extension Notification {
    public var appNotificationType: AppNotificationType {
        return self.notificationType()
    }
    
}
