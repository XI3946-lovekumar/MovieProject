//
//  MoviesDetailViewController.swift
//  MoviesProject
//
//  Created by Apple on 11/01/23.
//

import UIKit

final class MoviesDetailViewController: UIViewController {
    ///IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    ///Varriables
    var headerSize = UIScreen.main.bounds.size
    let viewModel = MoviesDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCollectionView()
        hitMoviesDetailAPI()
    }
    
    private func setUpCollectionView() {
        collectionView.registerCollectionViewClass(Key.Cell_Id.moviesDetailCell.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func crossButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func hitMoviesDetailAPI() {
        viewModel.moviesDetailAPI {
            self.reloadCollectionView()
        } failure: { error in
            self.showAlert(message: error.debugDescription ?? "")
        }
    }
    
    private func reloadCollectionView() {
        self.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
