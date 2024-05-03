//
//  ViewController.swift
//  In App Purchase
//
//  Created by Kerem Demir on 3.05.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var models = [PurchaseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        configureTableView()
        setupPurchaseModel()
        setupHeader()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: Functions
    private func setupPurchaseModel() {
        models.append(PurchaseModel(title: "500 Diamonds", handler: {
            PurchaseManager.shared.purchase(product: .diamond_500) { [weak self] count in
                
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeader()
                }
            }}))
        
        models.append(PurchaseModel(title: "1000 Diamonds", handler: {
            PurchaseManager.shared.purchase(product: .diamond_1000) { [weak self] count in
                
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeader()
                }
            }}))
        
        models.append(PurchaseModel(title: "2000 Diamonds", handler: {
            PurchaseManager.shared.purchase(product: .diamond_2000) { [weak self] count in
                
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeader()
                }
            }}))
        
        models.append(PurchaseModel(title: "5000 Diamonds", handler: {
            PurchaseManager.shared.purchase(product: .diamond_5000) { [weak self] count in
                
                DispatchQueue.main.async {
                    let currentCount = self?.myDiamondsCount ?? 0
                    let newCount = currentCount + count
                    UserDefaults.standard.setValue(newCount, forKey: "diamond_count")
                    self?.setupHeader()
                }
            }}))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model =  models[indexPath.row]
        
        cell.textLabel?.text = model.title
        cell.imageView?.image = UIImage(systemName: "suit.diamond.fill")
        cell.imageView?.tintColor = .systemBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model =  models[indexPath.row]
        model.handler()
    }
    
    var myDiamondsCount: Int {
        return UserDefaults.standard.integer(forKey: "diamond_count")
    }
    
    func setupHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 4))
        
        let imageView = UIImageView(image: UIImage(systemName: "suit.diamond.fill"))
        imageView.frame = CGRect(x: (view.frame.size.width - 100)/2, y: 10, width: 100, height: 100)
        imageView.tintColor = .systemBlue
        header.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 10, y: 120, width: view.frame.size.width - 20, height: 100))
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = "\(myDiamondsCount) Diamonds"
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
}
