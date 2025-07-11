//
//  Convert.swift
//  Currency Today
//
//  Created by Student on 02.07.25.
//

import UIKit

class ConvertOption {
    
    var name: String
    var BgI: UIImage
    var BgC: UIColor
    var api: String
    
    init(name: String, BgI: UIImage, BgC: UIColor, api: String) {
        self.name = name
        self.BgI = BgI
        self.BgC = BgC
        self.api = api
    }
}

class Convert: UIViewController {
    
    var models = [ConvertOption]()
    @IBOutlet weak var ConvertViewTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ConvertViewTable.delegate = self
        ConvertViewTable.dataSource = self
        ConvertViewTable.register(ConvertViewCell.self, forCellReuseIdentifier: ConvertViewCell.id)
        
        configure()

    }
    
    func configure(){
        
        models.append(contentsOf: [
            
            ConvertOption(name: "AMD", BgI: UIImage(named: "Armenia")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/AMD"),
            ConvertOption(name: "RUB", BgI: UIImage(named: "Russia")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/RUB"),
            ConvertOption(name: "USD", BgI: UIImage(named: "USA")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/USD"),
            ConvertOption(name: "GBP", BgI: UIImage(named: "Britain")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/GBP"),
            ConvertOption(name: "CHF", BgI: UIImage(named: "Switzerland")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/CHF"),
            ConvertOption(name: "EUR", BgI: UIImage(named: "Euro")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/EUR"),
            ConvertOption(name: "AFN", BgI: UIImage(named: "Afghanistan")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/AFN"),
            ConvertOption(name: "GEL", BgI: UIImage(named: "Georgia")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/GEL"),
            ConvertOption(name: "KZT", BgI: UIImage(named: "Kazakhstan")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/KZT"),
            ConvertOption(name: "BYN", BgI: UIImage(named: "Belarus")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/BYN"),
            ConvertOption(name: "ARS", BgI: UIImage(named: "Argentina")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/ARS"),
            ConvertOption(name: "AZN", BgI: UIImage(named: "Azerbeijan")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/AZN"),
            ConvertOption(name: "BRL", BgI: UIImage(named: "Brazil")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/BRL"),
            ConvertOption(name: "BGN", BgI: UIImage(named: "Bulgaria")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/BGN"),
            ConvertOption(name: "CAD", BgI: UIImage(named: "Canada")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/CAD"),
            ConvertOption(name: "CNY", BgI: UIImage(named: "China")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/CNY"),
            ConvertOption(name: "FJD", BgI: UIImage(named: "Fiji")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/FJD"),
            ConvertOption(name: "INR", BgI: UIImage(named: "India")!, BgC: .systemTeal, api: "https://open.er-api.com/v6/latest/INR"),

        ])
        
    }
    

    
    @IBAction func ChangeButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Change") as? Change
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }
    
   
        @IBAction func SettingsButton(_ sender: Any) {
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as? Settings
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
            
    }

}

extension Convert: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConvertViewCell.id, for: indexPath) as? ConvertViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ConvertViewTable.deselectRow(at: indexPath, animated: true)
        
        if  models[indexPath.item].name != ""{
            let vc = storyboard?.instantiateViewController(identifier: "ChangeViewController") as! ChangeViewController
            vc.ap = models[indexPath.item].api
            vc.text = models[indexPath.item].name
            self.present(vc,animated: true)
        }
        
    }
}
