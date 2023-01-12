//
//  MoviesViewController.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import UIKit

final class MoviesViewController: UIViewController {
    ///IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    ///Varriable
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        getPopularData()
        getNowPlayingAPI()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerTableViewClass(Key.Cell_Id.mostPopularCell.rawValue)
        tableView.registerTableViewClass(Key.Cell_Id.tableCell.rawValue)
        tableView.registerHeaderViewClass(Key.Header_Id.moviesHeaderView.rawValue)
    }
    
    func getPopularData() {
        viewModel.popularAPI {
            self.tableView.reloadData()
        } failure: { error in
            self.showAlert(message: error.debugDescription ?? "")
        }
    }
    
    func getNowPlayingAPI() {
        viewModel.nowPlayingAPI {
            self.tableView.reloadData()
        } failure: { error in
            self.showAlert(message: error.debugDescription)
        }
    }
    
    func presentMoviesDetail(_ movieId: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Key.VC_Id.moviesDetail.rawValue) as! MoviesDetailViewController
        vc.viewModel.movieId = movieId
        self.present(vc, animated: true)
    }
}
