//
//  LevelsTableViewCell.swift
//  App2
//
//  Created by Giuseppe Pio D'Ambrosio on 16/04/21.
//

import UIKit

class LevelsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
