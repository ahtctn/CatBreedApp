//
//  ViewController.swift
//  CatAPI
//
//  Created by Ahmet Ali ÇETİN on 28.03.2023.
//

import UIKit

class CatListViewController: UIViewController {
    
    //MARK: PROPERTIES
    private var viewModel = BreedViewModel()
    
    //MARK: OUTLETS
    @IBOutlet weak var catlistTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        customizeActivityIndicator()
        catlistTableView.delegate = self
        catlistTableView.dataSource = self
    }


}

extension CatListViewController {
    func configuration() {
        catlistTableView.register(UINib(nibName: "CatListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.Cell.id)
        observeEvent()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                
                //indicatorAlpha = 1
                
                print("breed loading")
                break
            case .stopLoading:
                print("breed has stopped the loading")
                
                DispatchQueue.main.async {
                    self.indicatiorStopAnimating()
                }
                
                break
            case .dataLoaded:
                
                DispatchQueue.main.async { [self] in
                    self.catlistTableView.reloadData()
                    print("buradan = \(self.viewModel.breeds.count)")
                }
                
            case .error(let error):
                print(error?.localizedDescription as Any)
            }
        }
    }
}

extension CatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(viewModel.breeds.count) buradan print oluyor.")
        return viewModel.breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.id, for: indexPath) as? CatListTableViewCell else {
            return UITableViewCell()
        }
        
        let breed = viewModel.breeds[indexPath.row]
        
        
        cell.breed = breed
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CatListViewController {
    private func customizeActivityIndicator() {
        indicatorView.style = .large
        indicatorView.isHidden = false
        indicatorView.alpha = 1
        indicatorView.startAnimating()
    }
    
    private func indicatiorStopAnimating() {
        indicatorView.alpha = 0
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
    }

}
