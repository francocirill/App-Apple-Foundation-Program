//
//  LevelCollectionViewCell.swift
//  App2
//
//  Created by Giuseppe Pio D'Ambrosio on 15/04/21.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var imageLevel: UIImageView!
    
    func configure(levelNumber: String, levelImage: UIImage){
        level.text = levelNumber
        imageLevel.image = levelImage
    }
}
