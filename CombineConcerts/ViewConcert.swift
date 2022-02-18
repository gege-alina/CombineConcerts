//
//  ViewConcert.swift
//  Concert list
//
//  Created by georgiana.stefan 
//

import Foundation
import UIKit
import RxSwift

class ViewConcert: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var bandTextField: UILabel!
    @IBOutlet weak var placeTextField: UILabel!
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    var viewModel: Concert?
    
    let concertPaidTapped = PublishSubject<Void>()
    var concertPaid: Observable<Void> {
        concertPaidTapped.asObservable()
    }
    
    init(with viewModel: Concert, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = viewModel
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
        concertPaidTapped.onNext(())
    }
    
    private func updateUI() {
        bandTextField.text = viewModel?.bandName
        placeTextField.text = viewModel?.placeOfConcert
        let dateFormatter = DateFormatter()
        timeTextField.text = dateFormatter.string(from: viewModel?.dateOfConcert ?? Date() + 7)
        payButton.setBackgroundImage( viewModel?.isPaid ?? false ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
}
