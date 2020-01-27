//
//  ViewController.swift
//  MCSFirstApp
//
//  Created by mcs on 1/21/20.
//  Copyright © 2020 mcs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slider: UISlider!
    
    var json: RootClass?
    var char: [RelatedTopic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let url = Bundle.main.url(forResource: "Simpsons", withExtension: "json")!
            let jsonString = try String(contentsOf: url)
            let data = jsonString.data(using: .utf8)!
            
            json = try JSONDecoder().decode(RootClass.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        slider.value = 1
        char = json?.relatedTopics
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return char?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.isHidden = slider.value < 0.5
        cell.label.text = char?[indexPath.row].text
        
        cell.img.isHidden = slider.value != 1
        cell.img.contentMode = .scaleToFill
        cell.img.downloadImageFrom(link: char?[indexPath.row].icon.url ?? "", contentMode: .scaleAspectFit)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Simpsons Squad"
    }
}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
