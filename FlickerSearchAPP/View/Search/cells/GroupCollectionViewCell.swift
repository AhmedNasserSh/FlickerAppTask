//
//  GroupCollectionViewCell.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!

    func configure(group:Group) {
        self.nameLabel.text = group.name
        self.membersLabel.text = group.members
        self.photoLabel.text = group.poolCount
    }
}
