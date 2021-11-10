//
//  DetailViewController.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func display(viewModel: DetailView.ViewModel)
    func displaySavingToGallery()
}

final class DetailViewController: UIViewController {
    private let interactor: DetailBusinessLogic
    
    private lazy var contentView: DetailView = {
        let view = DetailView()
        view.delegate = self
        return view
    }()
    
    init(interactor: DetailBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DetailViewController: DetailDisplayLogic {
    func displaySavingToGallery() {
        guard let image = contentView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func display(viewModel: DetailView.ViewModel) {
        navigationItem.title = "Detail"
        contentView.setup(viewModel: viewModel)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        // Can be moved to coordinator for more flexible flow or screen logic
        if error != nil {
            let controller = UIAlertController(
                title: "Save error",
                message: "",
                preferredStyle: .alert
            )
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
        } else {
            let controller = UIAlertController(
                title: "Saved!",
                message: "Your image has been saved to your photos.",
                preferredStyle: .alert
            )
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
        }
    }
}

extension DetailViewController: DetailViewDelegate {
    func saveTapped() {
        interactor.saveTapped()
    }
}
