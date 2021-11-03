//
//  Module.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

public final class Module<ModuleInputType> {
    public var input: ModuleInputType
    public var view: UIViewController

    public init(input: ModuleInputType, view: UIViewController) {
        self.input = input
        self.view = view
    }
}
