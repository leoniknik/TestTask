//
//  UIView+AddViewBuilder.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

/// Конструктор функций для добавления дочерних вьюшек в иерархичном виде
@resultBuilder
public struct AddViewBuilder {
    public static func buildBlock(_ views: UIView...) -> [UIView] { views }

    public static func buildBlock(_ views: [UIView]) -> [UIView] { views }

    public static func buildBlock(_ view: UIView?) -> [UIView] {
        guard let view = view else { return [] }
        return [view]
    }
}

/// Расширение для добавления дочерних вьюшек в иерархичном виде
extension UIView {
    /// Добавить несколько вьюшек
    /// - Parameter block: Блок, возвращающий массив вьюшек
    @discardableResult
    public func add(@AddViewBuilder _ block: () -> ([UIView])) -> UIView {
        if let stackView = self as? UIStackView {
            block().forEach {
                stackView.addArrangedSubview($0)
            }
        } else {
            block().forEach {
                addSubview($0)
            }
        }
        return self
    }

    /// Добавить массив вьюшек
    /// - Parameter views: Массив вьюшек
    @discardableResult
    public func add(_ views: [UIView]) -> UIView {
        if let stackView = self as? UIStackView {
            views.forEach {
                stackView.addArrangedSubview($0)
            }
        } else {
            views.forEach {
                addSubview($0)
            }
        }
        return self
    }

    /// Добавить одну вьюшку
    /// - Parameter block: Блок, возвращающий вьюшку
    @discardableResult
    public func add(@AddViewBuilder _ block: () -> (UIView?)) -> UIView {
        guard let view = block() else { return self }
        if let stackView = self as? UIStackView {
            stackView.addArrangedSubview(view)
        } else {
            addSubview(view)
        }
        return self
    }

    /// Вставляет одну вьюшку по индексу
    /// - Parameter index: Индекс вставки вьюшки
    /// - Parameter block: Блок, возвращающий вьюшку
    @discardableResult
    public func insert(at index: Int, _ block: () -> (UIView)) -> UIView {
        if let stackView = self as? UIStackView {
            stackView.insertArrangedSubview(block(), at: index)
        } else {
            insertSubview(block(), at: index)
        }
        return self
    }
}
