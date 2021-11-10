//
//  FeedViewController.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol FeedDisplayLogic: AnyObject {
    func display(viewModel: FeedView.ViewModel)
    func display(isLoading: Bool)
}

final class FeedViewController: UIViewController {
    private let interactor: FeedBusinessLogic
    
    private lazy var contentView: FeedView = {
        let view = FeedView()
        view.delegate = self
        return view
    }()
    
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
    func display(isLoading: Bool) {
        contentView.display(isLoading: isLoading)
    }
    
    func display(viewModel: FeedView.ViewModel) {
        contentView.setup(viewModel: viewModel)
    }
}

extension FeedViewController: UISearchControllerDelegate {
    
}

extension FeedViewController: FeedViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        interactor.didSelectItem(with: indexPath.row)
    }
}
