//
//  PagingViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Maple on 2019/2/26.
//  Copyright © 2019 Maple. All rights reserved.
//

import UIKit


open class PagingViewController: UIViewController {
    
    public let controllers: [UIViewController]
    // 设置 get 方法为 public set 方法为默认模块内课访问
    public internal(set) var currentViewController: UIViewController!
    // 设置 get 方法为 public set 方法为文件内私有
    public fileprivate(set) var visibleControllers = [UIViewController]()
    
    internal let contentScrollView: UIScrollView = {
        $0.isPagingEnabled = true
        $0.isDirectionalLockEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView(frame: .zero))
    
    fileprivate let options: PagingMenuControllerCustomizable
    fileprivate var currentIndex: Int = 0
    
    init(viewControllers: [UIViewController], options: PagingMenuControllerCustomizable) {
        controllers = viewControllers
        self.options = options
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    fileprivate func setupView() {
        view.backgroundColor = options.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupContentScrollView() {
        contentScrollView.backgroundColor = options.backgroundColor
        contentScrollView.isScrollEnabled = options.isScrollEnabled
        view.addSubview(contentScrollView)
    }
    
    fileprivate func layoutContentScrollView() {
        NSLayoutConstraint.activate([
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    fileprivate func constructPageViewControllers() {
        for (index, controller) in controllers.enumerated() {
            // construct three child view controllers at a maximut, previous(optional), current, and next(optional)
            if !shouldLoad(page: index) {
                // remove unnecessary child view controllers
                if isVisible(controller: controller) {
                    controller.willMove(toParent: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParent()
                    
                    let _ = visibleControllers.index(of: controller).flatMap {
                        visibleControllers.remove(at: $0)
                    }
                }
                continue
            }
            // ignore if it is already added
            if isVisible(controller: controller) {
                continue
            }
            
            guard let pagingView = controller.view else {
                fatalError("\(controller) doesn't have any view")
            }
            
            pagingView.frame = .zero
            pagingView.backgroundColor = pagingView.backgroundColor ?? options.backgroundColor
            pagingView.translatesAutoresizingMaskIntoConstraints = false
            
            contentScrollView.addSubview(pagingView)
            addChild(controller as UIViewController)
            controller.didMove(toParent: self)
            
            visibleControllers.append(controller)
        }
    }
    
    fileprivate func layoutPagingViewControllers() {
        //cleanup
        NSLayoutConstraint.deactivate(contentScrollView.constraints)
        
        for(index, controller) in controllers.enumerated() {
            if !shouldLoad(page: index) {
                continue
            }
            guard let pagingView = controller.view else { continue}
            
            // only one view controller
//            if options.lazyLoadingPage == LazyLoadingPage.one ||
//            controllers.count == Mini
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension PagingViewController: Pagable {
    public var currentPage: Int {
        return currentIndex
    }
    
    var previousPage: Int {
        
        guard case .all(let menuOptions, _) = options.componentType, case .infinite = menuOptions.displayMode  else {
            return currentPage - 1
        }
        return currentPage - 1 < 0 ? menuOptions.itemOptions.count - 1 : currentPage - 1
    }
    
    var nextPage: Int {
        
        guard case .all(let menuOptions, _) = options.componentType, case .infinite = menuOptions.displayMode  else {
            return currentPage + 1
        }
        return currentPage + 1 > menuOptions.itemOptions.count - 1 ? 0 : currentPage + 1
    }
    
    func update(currentPage page: Int) {
        currentIndex = page
    }
}

// MARK: Page Control
extension PagingViewController {
    
    fileprivate func shouldLoad(page: Int) -> Bool {
        switch (options.menuControllerSet, options.lazyLoadingPage) {
        case (.single, _),
             (_, .one):
            guard page == currentPage else { return false}
        case (_, .three):
            if case .all(let menuOPtions, _) = options.componentType, case .infinite = menuOPtions.displayMode {
                guard page == currentPage || page == previousPage || page == nextPage else { return false }
            }else {
                guard page >= previousPage && page <= nextPage else { return false }
            }
        case (_, .all) : return true
        }
        return true
    }
    
    fileprivate func isVisible(controller: UIViewController) -> Bool {
        return self.children.contains(controller)
    }
}
