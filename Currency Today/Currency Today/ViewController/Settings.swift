//
//  Settings.swift
//  Currency Today
//
//  Created by Student on 02.07.25.
//

import UIKit

class SettingsOption{
    
    var name: String
    var BgI: UIImage
    var BgC: UIColor
    
    init(name: String, BgI: UIImage, BgC: UIColor) {
        self.name = name
        self.BgI = BgI
        self.BgC = BgC
    }
}

class Settings: UIViewController {

    var models = [SettingsOption]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        configure()
        
    }
    
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About Programm", BgI: UIImage(systemName: "info.circle")!, BgC: .systemMint),
            SettingsOption(name: "Share", BgI: UIImage(systemName: "square.and.arrow.up.on.square")!, BgC: .systemMint),
            SettingsOption(name: "Contact", BgI: UIImage(systemName: "person.badge.shield.checkmark")!, BgC: .systemMint),
            SettingsOption(name: "By", BgI: UIImage(systemName: "person.icloud")!, BgC: .systemMint)
            
        ])
    }
    
    @IBAction func ChangeButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Change") as? Change
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }
    

        @IBAction func ConvertButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "Convert") as? Convert
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }

}

extension Settings: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as? SettingsTableViewCell
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
        self.tableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name == "About programm" {

                    let actionSheet = UIAlertController(title: "About proggramm 4567898", message: nil, preferredStyle: .actionSheet)

                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    present(actionSheet, animated: true)

                }else if models[indexPath.item].name == "Share" {

                    let activityVc = UIActivityViewController(activityItems: [""], applicationActivities: nil)

                    activityVc.popoverPresentationController?.sourceView = self.view

                    self.present(activityVc, animated: true)

                }else if models[indexPath.item].name == "Contact" {

                    let actionSheet = UIAlertController(title: "Facebook", message: nil, preferredStyle: .actionSheet)

                    actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (action) in

                        UIApplication.shared.openURL(NSURL(string: "")! as URL)

                    }))

                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                    present(actionSheet, animated: true)

                }else if models[indexPath.item].name == "By" {

                let actionSheet = UIAlertController(title: "By ©Vahan Danielyan", message: nil, preferredStyle: .actionSheet)

                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                present(actionSheet, animated: true)

                }
            
        }
    }



