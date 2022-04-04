//
//  TableViewCell.swift
//  InstagramApp
//
//  Created by Максим Пасюта on 22.03.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func refresh(model: Post){
        
        pictureView.sd_setImage(with: URL(string: model.url), completed: nil)
        iconImageView.sd_setImage(with: URL(string: model.thumbnailUrl), completed: nil)
        titleLabel.text = "\(model.id)"
        bodyLabel.text = model.title
        
    }
}
