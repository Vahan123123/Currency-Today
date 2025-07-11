//
//  Change.swift
//  Currency Today
//
//  Created by Student on 02.07.25.
//

import UIKit

class ChangeOption {
    
    var name: String
    var currency: String
    var BgC: UIColor
    var BgI: UIImage
    var course: String
    
    init(name: String, currency: String, BgC: UIColor, BgI: UIImage, course: String) {
        self.name = name
        self.currency = currency
        self.BgC = BgC
        self.BgI = BgI
        self.course = course
    }
    
}

class Change: UIViewController{


    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBOutlet weak var TableView: UITableView!
    
    var models = [ChangeOption]()
    var volues: [Double] = []
    var currencyCode: [String] = []
    override func viewDidLoad(){
        super.viewDidLoad()
            TableView.delegate = self
            TableView.dataSource = self
        TableView.register(ChangeTableViewCell.self, forCellReuseIdentifier: ChangeTableViewCell.id)
            currentDate()
        configure()
        fetchJson()
    }
    
    func configure(){
        models.append(contentsOf: [
            ChangeOption(name: "AMD", currency: "Armenia", BgC: .cyan, BgI: UIImage(named: "Armenia")!, course: "1"),
            ChangeOption(name: "RUB", currency: "Russia", BgC: .cyan, BgI: UIImage(named: "Russia")!, course: "1"),
            ChangeOption(name: "USD", currency: "USA", BgC: .cyan, BgI: UIImage(named: "USA")!, course: "1"),
            ChangeOption(name: "GBP", currency: "Great Britain", BgC: .cyan, BgI: UIImage(named: "Britain")!, course: "1"),
            ChangeOption(name: "CHF", currency: "Switzerland", BgC: .cyan, BgI: UIImage(named: "Switzerland")!, course: "1"),
            ChangeOption(name: "EUR", currency: "Europa", BgC: .cyan, BgI: UIImage(named: "Euro")!, course: "1"),
            ChangeOption(name: "AFN", currency: "Afganistan", BgC: .cyan, BgI: UIImage(named: "Afghanistan")!, course: "1"),
            ChangeOption(name: "GEL", currency: "Georgia", BgC: .cyan, BgI: UIImage(named: "Georgia")!, course: "1"),
            ChangeOption(name: "KZT", currency: "Kazakhstan", BgC: .cyan, BgI: UIImage(named: "Kazakhstan")!, course: "1"),
            ChangeOption(name: "BYN", currency: "Belarus", BgC: .cyan, BgI: UIImage(named: "Belarus")!, course: "1"),
            ChangeOption(name: "ARS", currency: "Argentina", BgC: .cyan, BgI: UIImage(named: "Argentina")!, course: "1"),
            ChangeOption(name: "AZN", currency: "Azerbeijan", BgC: .cyan, BgI: UIImage(named: "Azerbeijan")!, course: "1"),
            ChangeOption(name: "BRL", currency: "Brazil", BgC: .cyan, BgI: UIImage(named: "Brazil")!, course: "1"),
            ChangeOption(name: "BGN", currency: "Bulgaria", BgC: .cyan, BgI: UIImage(named: "Bulgaria")!, course: "1"),
            ChangeOption(name: "CAD", currency: "Canada", BgC: .cyan, BgI: UIImage(named: "Canada")!, course: "1"),
            ChangeOption(name: "CNY", currency: "China", BgC: .cyan, BgI: UIImage(named: "China")!, course: "1"),
            ChangeOption(name: "FJD", currency: "Fiji", BgC: .cyan, BgI: UIImage(named: "Fiji")!, course: "1"),
            ChangeOption(name: "INR", currency: "India", BgC: .cyan, BgI: UIImage(named: "India")!, course: "1"),
        ])
    }
        
        func fetchJson(){

                guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else {return}

                URLSession.shared.dataTask(with: url) {[self] (data, response, error) in

                    if error != nil {

                        print(error!.localizedDescription)

                        return

                    }

                    guard let safeData = data else {return}

                    do{

                        let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)

                        self.currencyCode.append(contentsOf: rezults.rates.keys)

                        self.volues.append(contentsOf: rezults.rates.values)

                        rezults.rates.forEach { (key, value) in

                            self.models = self.models.map {

                                if $0.name == key {

                                    let courseKey = (Double(models[0].course) ?? 0)/value

                                    $0.course = "\(Double(round(100 * courseKey) / 100))"

                                }

                                return $0

                            }

                        }

                        DispatchQueue.main.async {

                            self.TableView.reloadData()

                        }

                    }

                    catch {

                        print(error)

                    }

                }.resume()

            

    }
    
    func currentDate(){
        
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        NavBar.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
        
        
    }
    
    @IBAction func ConvertButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Convert") as? Convert
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

extension Change:UITableViewDelegate,
                 UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeTableViewCell.id, for: indexPath) as? ChangeTableViewCell
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
        self.TableView.deselectRow(at: indexPath, animated: true)
    }
    
}
