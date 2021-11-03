//
//  Coordinator.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

/// Базовый протокол координатора
public protocol CoordinatorProtocol: AnyObject {
    /// Дочерние координаторы
    var childCoordinators: [String: CoordinatorProtocol] { get set }

    /// Родительский координатор
    var parentCoordinator: CoordinatorProtocol? { get set }

    /// Старт флоу
    func start()

    /// Первый респондер в responder chain реализующий данный протокол
    func firstResponder<T>(of type: T.Type) -> T?
}

/// Дефолтная реализация координатора
open class Coordinator: NSObject, CoordinatorProtocol {
    /// Первый респондер в responder chain реализующий данный протокол
    public func firstResponder<T>(of type: T.Type) -> T? {
        if let responder = self as? T {
            return responder
        } else {
            guard let parent = parentCoordinator else { return nil }
            return parent.firstResponder(of: type)
        }
    }

    /**
     Добавление дочернего координатора
     - parameter coordinator: Координатор
     */
    public func addCoordinator(_ coordinator: CoordinatorProtocol) {
        let name = String(describing: type(of: coordinator))
        coordinator.parentCoordinator = self as CoordinatorProtocol
        childCoordinators[name] = coordinator
    }

    /**
     Удаление дочернего координатора по типу
     - parameter type: Тип координатора
     */
    public func removeCoordinator(type: CoordinatorProtocol.Type) {
        let name = String(describing: type)
        childCoordinators[name] = nil
    }

    /**
     Получение дочернего координатора по типу
     - parameter type: Тип координатора
     */
    public func getCoordinator<T: CoordinatorProtocol>(type: T.Type) -> T? {
        childCoordinators[String(describing: type)] as? T
    }

    public var childCoordinators: [String: CoordinatorProtocol]
    public var parentCoordinator: CoordinatorProtocol?

    public override init() {
        childCoordinators = [:]
        parentCoordinator = nil
        super.init()
    }

    open func start() { }
}
