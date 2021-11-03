//
//  FeedViewController.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    
}

final class FeedViewController: UIViewController {
    private let interactor: FeedBusinessLogic
    
    init(interactor: FeedBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = FeedView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Search photo"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension FeedViewController: FeedDisplayLogic {
    
}

extension FeedViewController: UISearchControllerDelegate {
    
}
