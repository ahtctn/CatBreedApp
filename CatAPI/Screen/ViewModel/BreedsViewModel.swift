//
//  BreedsViewModel.swift
//  CatAPI
//
//  Created by Ahmet Ali ÇETİN on 28.03.2023.
//

import UIKit

class BreedViewModel {
    var breeds = [BreedModel]()
    var eventHandler: ((_ event: Event ) -> Void)?
    
    
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchBreeds { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let breedList):
                self.breeds = breedList
                self.eventHandler?(.dataLoaded)
                
//                for breed in self.breeds {
//                    print(breed.name)
//                }
                //print(breedList.count)
                
                break
            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error.localizedDescription)
                break
            }
        }
    }
}

extension BreedViewModel {
    enum Event {
        case loading
        case dataLoaded
        case stopLoading
        case error(_ error: Error?)
    }
}
