//
//  ViewConcert.swift
//  Concert list
//
//  Created by georgiana.stefan 
//

import Foundation
import UIKit
import Combine

class ViewConcert: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var bandTextField: UILabel!
    @IBOutlet weak var placeTextField: UILabel!
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    var viewModel: Concert?
    
    let concertPaidTap = PassthroughSubject<Void, Error>()
    let paySubject = CurrentValueSubject<State, Error>(.notPaid)
    
    init(with viewModel: Concert, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = viewModel
        //self.concertPaid = concertPaidTap.eraseToAnyPublisher()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func payButtonTapped() {
        payButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        
        if paySubject.value == .notPaid {
            paySubject.value = .paid
            viewModel?.isPaid = true
        } else {
            paySubject.value = .notPaid
            viewModel?.isPaid = false
        }
        updateUI()
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        bandTextField.text = viewModel.bandName
        placeTextField.text = viewModel.placeOfConcert
        let dateFormatter = DateFormatter()
        timeTextField.text = dateFormatter.string(from: viewModel.dateOfConcert ?? Date() + 7)
        payButton.setBackgroundImage( viewModel.isPaid ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
}
