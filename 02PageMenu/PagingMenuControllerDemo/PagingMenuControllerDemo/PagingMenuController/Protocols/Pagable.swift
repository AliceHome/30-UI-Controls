//
//  Pagable.swift
//  PagingMenuControllerDemo
//
//  Created by Maple on 2019/2/27.
//  Copyright © 2019 Maple. All rights reserved.
//

import Foundation

protocol Pagable {
    
    var currentPage: Int { get }
    var previousPage: Int { get }
    var nextPage: Int { get }
    func update(currentPage page: Int)
}

extension Pagable {
    func update(currentPage page: Int) {}
}
