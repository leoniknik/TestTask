//
//  Cancelable.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import Foundation

protocol Cancelable {
    func cancel()
}

extension DispatchWorkItem: Cancelable {}
