//
//  ViewController.swift
//  Concert list
//
//  Created by georgiana.stefan on
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    //private let disposeBag = DisposeBag()
    //private var concerts = BehaviorRelay<[Concert]>(value: [])
    private var concerts = Array<Concert>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ConcertTableViewCell", bundle: nil), forCellReuseIdentifier: "ConcertTableViewCellIdentifier")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        concerts = [Concert(band: "TMJ")]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationControler = segue.destination as? UINavigationController,
           let destination = navigationControler.viewControllers.first as? AddConcertViewController {
            
            _ = destination.concertSubjectObservable
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [weak self] concert in
                    self?.concerts.append(concert)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                })
//        destination.concertSubjectObservable
//            .subscribe(onNext: { concert in
//                var myConcerts = self.concerts.value
//                myConcerts.append(concert)
//                self.concerts.accept(myConcerts)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            })
//            .disposed(by: disposeBag)
        } else if let identifier = segue.identifier, identifier == "viewConcert",
                  let destination = segue.destination as? ViewConcert, let index = sender as? IndexPath {
            let concert = concerts[index.row]
            destination.viewModel = concert
//            destination.concertPaid
//                .subscribe(onNext: { _ in
//                    var myConcert = self.concerts.value[index.row]
//                    myConcert.isPaid = true
//                    var myConcerts = self.concerts.value
//                    myConcerts[index.row] = myConcert
//                    self.concerts.accept(myConcerts)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                })
//                .disposed(by: disposeBag)
        }
    }

}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewConcert", sender: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let viewModel = vm
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConcertTableViewCellIdentifier") as? ConcertTableViewCell else {
            return UITableViewCell()
        }
        let concert = concerts[indexPath.row]
        let cellVM = concert.getConcertCellVM()
        cell.viewModel = cellVM
        return cell
    }
}
