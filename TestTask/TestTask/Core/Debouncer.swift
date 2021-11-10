//
//  Debouncer.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import Foundation

protocol DebouncerProtocol {
    func debounce(block: @escaping () -> ())
    func flush()
}

public final class Debouncer {
    private let queue = DispatchQueue(label: "com.testtask.throttler", qos: .default)

    private var job = DispatchWorkItem(block: {})
    private var delay: TimeInterval

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    public func debounce(block: @escaping () -> ()) {
        job.cancel()
        job = DispatchWorkItem { [weak self] in
            guard self?.job.isCancelled == false else { return }
            block()
        }
        queue.asyncAfter(deadline: .now() + delay, execute: job)
    }

    public func flush() {
        job.cancel()
    }
}

extension Debouncer: DebouncerProtocol {
    
}
