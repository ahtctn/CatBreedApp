//
//  CatListTableViewCell.swift
//  CatAPI
//
//  Created by Ahmet Ali ÇETİN on 28.03.2023.
//

import UIKit

class CatListTableViewCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var catListBackgroundView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catTitleLabel: UILabel!
    @IBOutlet weak var catDescriptionLabel: UILabel!
    
    var breed: BreedModel? {
        didSet {
            breedListConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func breedListConfiguration() {
        guard let breed = breed else { return }
        catTitleLabel.text = breed.name
        catDescriptionLabel.text = breed.description
        //catImageView.image = UIImage(systemName: "person.fill")
    }
    
    fileprivate func setUIView() {
        catListBackgroundView.clipsToBounds = false
        catListBackgroundView.layer.cornerRadius = 15
        catListBackgroundView.layer.cornerRadius = 10
        self.catListBackgroundView.backgroundColor = .systemGray6
    }
    
}
