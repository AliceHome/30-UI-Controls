//
//  PagingMenuControllerCustomizable.swift
//  PagingMenuControllerDemo
//
//  Created by Maple on 2019/2/26.
//  Copyright © 2019 Maple. All rights reserved.
//

import UIKit
//Customizable  定制
public protocol PagingMenuControllerCustomizable {
    // get 表示属性为可读属性，可读属性表示该属性可以为任意属性
    var defaultPage: Int { get }
    var animationDuration: TimeInterval { get }
    var isScrollEnabled: Bool { get }
    var backgroundColor: UIColor { get }
    var lazyLoadingPage: LazyLoadingPage { get }
    var menuControllerSet: MenuControllerSet { get }
    var componentType: ComponentType { get }
}

public extension PagingMenuControllerCustomizable {
    var defaultPage: Int {
        return 0
    }
    
    var animationDuratioin: TimeInterval {
        return 0.3
    }
    
    var isScrollEnabled: Bool {
        return true
    }
    
    var backgroundColor: UIColor {
        return UIColor.white
    }
    
    var lazyLoadingPage: LazyLoadingPage {
        return .three
    }
    
    var menuControllerSet: MenuControllerSet {
        return .multiple
    }
    
}

public enum LazyLoadingPage {
    case one
    case three
    case all
}

public enum MenuControllerSet {
    case single
    case multiple
}

public enum ComponentType {
    case menuView(menuOptions: MenuViewCustomizable)
    case pagingController(pagingControllers: [UIViewController])
    case all(menuOptions: MenuViewCustomizable, pagingControllers: [UIViewController])
}
