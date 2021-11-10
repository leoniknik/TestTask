//
//  FeedDebounceWorker.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import Foundation

protocol FeedDebounceWorkerProtocol {
    func debounce(block: @escaping () -> ())
}

final class FeedDebounceWorker: FeedDebounceWorkerProtocol {
    private let debouncer: DebouncerProtocol
    
    init(debouncer: DebouncerProtocol) {
        self.debouncer = debouncer
    }
    
    func debounce(block: @escaping () -> ()) {
        debouncer.debounce {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
