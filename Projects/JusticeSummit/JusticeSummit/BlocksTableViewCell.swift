//
//  BlocksTableViewCell.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 3/3/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class BlocksTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionBlockTitle: UILabel!
    
    @IBOutlet weak var selectedSessionTitle: UILabel!
    
    @IBOutlet weak var completedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
