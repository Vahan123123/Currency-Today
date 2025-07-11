//
//  ChangeViewController.swift
//  Currency Today
//
//  Created by Student on 10.07.25.
//

import UIKit

class Piker {
    
    var name: String
    var count: Double
    
    init(name: String, count: Double) {
        self.name = name
        self.count = count
    }
    
}



class ChangeViewController: UIViewController {
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var CurrencyText: UITextField!
    @IBOutlet weak var FirstCount: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var Two: UIButton!
    @IBOutlet weak var Three: UIButton!
    @IBOutlet weak var Four: UIButton!
    @IBOutlet weak var Five: UIButton!
    @IBOutlet weak var Six: UIButton!
    @IBOutlet weak var Seven: UIButton!
    @IBOutlet weak var Eight: UIButton!
    @IBOutlet weak var Nine: UIButton!
    @IBOutlet weak var Enter: UIButton!
    @IBOutlet weak var Zero: UIButton!
    

    
    
    var dataSource: [Piker] = []
    var ap: String = ""
    var text: String = ""
    var activeCurrency = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyText.delegate = self
        CurrencyText.isUserInteractionEnabled = false
        CurrencyText.placeholder = "Your Money"
        FirstCount.adjustsFontSizeToFitWidth = true
        FirstCount.minimumScaleFactor = 0.2
        CurrencyText.addTarget(self, action: #selector(updateViews), for: .editingChanged)
        FirstLabel.text = text
        picker.delegate = self
        picker.dataSource = self
        fetchJson()

        picker.setValue(UIColor.black, forKey: "textColor")
        picker.tintColor = .black
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchJson() {
            guard let url = URL(string: ap) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let safeData = data else { return }
                do {
                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                
                    self.dataSource = rezults.rates.map {
                        Piker(name: $0.key, count: $0.value)
                    }.sorted(by: {$0.name < $1.name})
                    DispatchQueue.main.async {
                        self.picker.reloadAllComponents()
                        self.activeCurrency = self.dataSource[0].count
                    }
                }
                catch {
                    print(error)
                }
            }.resume()
        }
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func getNum(_ sender: Any){
        
        CurrencyText.text = CurrencyText.text! + String((sender as AnyObject).tag)
    }
    
    @IBAction func deleteNum(_ sender: Any) {
        CurrencyText.text = String(CurrencyText.text!.dropLast())
    }
    
    @IBAction   func Enter(_ sender: Any){
        guard let amontText = CurrencyText.text, let theAmontText = Double(amontText)
        else {return}
        if CurrencyText.text != "" {
            let total = theAmontText * activeCurrency
            FirstCount.text = String(format: "%.2f", total)
        }
    }

    @objc func updateViews(input: Double) {
        guard let amontText = CurrencyText.text, let theAmontText = Double(amontText)
        else {return}
        if CurrencyText.text != "" {
            let total = theAmontText * activeCurrency
            FirstCount.text = String(format: "%.2f", total)
        }
    }
}

extension ChangeViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = dataSource[row].count
        updateViews(input: activeCurrency)
    }
}
