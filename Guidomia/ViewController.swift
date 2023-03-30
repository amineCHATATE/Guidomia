//
//  ViewController.swift
//  Guidomia
//
//  Created by Amine CHATATE on 30/3/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    
    var cars = [CarModel]() {
        didSet {
            guard cars != oldValue else { return }
            carsDidUpdate()
        }
    }
    
    var makeQuery = ""
    var modelQuery = ""
    
    var expandedIndexSet = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        makeTextField.delegate = self
        modelTextField.delegate = self
        
        self.loadCars()
        
        //tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        
        title = "Guidomia"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 252, green: 96, blue: 22, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.layoutSubviews()
    }
    
    private func carsDidUpdate(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadCars() {
        // Get the Cars
        ApiCall.getDataFromFileWithSuccess { cars in
            self.cars = cars
        }
    }


}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            print("failed to get cell")
            return UITableViewCell()
        }
        
        // Configure the cell
        let car = self.cars[indexPath.row]
        let carViewModel = CarViewModel(consList: car.consList, customerPrice: car.customerPrice, make: car.make, marketPrice: car.marketPrice, model: car.model, prosList: car.prosList, rating: car.rating)
        
        cell.configure(with: carViewModel)
        cell.selectionStyle = .none
        
        UIView.animate(withDuration: 1, delay: 0.5) {
            if self.expandedIndexSet == indexPath.row {
                cell.expand(with: carViewModel)
            } else {
                cell.collapse()
            }
        }
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        expandedIndexSet = indexPath.row
        tableView.reloadData()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField.text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //let text = (tfOutlet.text! as NSString).replacingCharacters(in: range, with: string)

        if let tag1 = textField.viewWithTag(1) {
            print(tag1)
        }
        /*if (tag1) {
            print("1 text: \(textField.text)")
        }
        
        if textField.viewWithTag(0) {
            print("2 text: \(textField.text)")
        }*/
        
        return true
    
    }
}

