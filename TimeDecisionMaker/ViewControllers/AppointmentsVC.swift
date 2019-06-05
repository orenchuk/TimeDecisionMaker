//
//  AppointmentsVC.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/5/19.
//

import UIKit

final class AppointmentsVC: UIViewController {
    
    // MARK: - Properties
   
    private let model = AppointmetnsViewModel()
    private let cellIdentifier = "AppointmentIntervalCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var timePicker: UIDatePicker!
    @IBOutlet private weak var datePicker: UIView!
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        model.suggestFreeIntervals(duration: sender.countDownDuration)
        tableView.reloadData()
        titleLabel.text = "Intervals suggestions: \(model.intervals.count)"
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        model.suggestFreeIntervals(duration: timePicker.countDownDuration)
        titleLabel.text = "Intervals suggestions: \(model.intervals.count)"
        
        timePicker.roundCorners(radius: Constants.Radius.standart)
        timePicker.backgroundColor = #colorLiteral(red: 0.2076497674, green: 0.22406739, blue: 0.269911617, alpha: 1)
        tableView.backgroundColor = .clear
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.roundCorners(radius: Constants.Radius.standart)
    }
}

// MARK: - TableView delegates

extension AppointmentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Height.intervalCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.intervals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AppointmentIntervalCell else { return UITableViewCell() }
            cell.start = model.intervals[indexPath.row].start
            cell.end = model.intervals[indexPath.row].end
            return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
