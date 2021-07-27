//
//  ComicViewController.swift
//  Disney
//
//  Created by Pierre Moreau on 7/25/21.
//

import UIKit
import Combine

class ComicViewController: UIViewController {
    var viewModel = ComicViewModel()
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnailView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descritionLabel: UILabel?
    @IBOutlet weak var spinnerView: UIActivityIndicatorView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBindings()
        viewModel.loadComic()
    }
    
    private func setUpBindings() {
        
        viewModel.comicState
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] newState in
                
                guard let nonNilSelf = self else { return }
                
                switch newState {
                    case .idle:
                        nonNilSelf.spinnerView?.stopAnimating()
                        
                    case .loading:
                        nonNilSelf.spinnerView?.startAnimating()
                        
                    case .success(comic: let comic):
                        nonNilSelf.spinnerView?.stopAnimating()
                        nonNilSelf.titleLabel?.text = comic.title
                        nonNilSelf.descritionLabel?.text = comic.description
                        
                    case .failure(error: let error):
                        nonNilSelf.spinnerView?.stopAnimating()
                        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                            nonNilSelf.viewModel.loadComic()
                        }))
                        nonNilSelf.present(alert, animated: true)
                }
            })
            .store(in: &bindings)
        
        viewModel.comicThumbnailImage.sink(receiveCompletion: { _ in },
                                       receiveValue: { [weak self] image in
                                        
            self?.thumbnailView?.image = image
        })
        .store(in: &bindings)
    }
}
