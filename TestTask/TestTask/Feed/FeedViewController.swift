//
//  FeedViewController.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func display(viewModel: FeedView.ViewModel)
}

final class FeedViewController: UIViewController {
    private let interactor: FeedBusinessLogic
    
    private lazy var contentView = FeedView()
    
    init(interactor: FeedBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        interactor.didSearch(text: "flower,car")
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
    func display(viewModel: FeedView.ViewModel) {
        contentView.setup(viewModel: viewModel)
    }
}

extension FeedViewController: UISearchControllerDelegate {
    
}
