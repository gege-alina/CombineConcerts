//
//  ConcertTableViewCell.swift
//  Concert list
//
//  Created by georgiana.stefan
//

import UIKit

class ConcertTableViewCell: UITableViewCell {

    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var placeOfConcert: UILabel!
    @IBOutlet weak var dateOfConcert: UILabel!
    @IBOutlet weak var paidFor: UIImageView!
    
    var viewModel: ConcertCellViewModel! {
        didSet {
            bandName.text = viewModel.bandName
            placeOfConcert.text = viewModel.placeOfConcert
            let dateFormatter = DateFormatter()
            dateOfConcert.text = dateFormatter.string(from: viewModel.dateOfConcert ?? Date() + 7)
            paidFor.image = viewModel.isConcertPaid ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
