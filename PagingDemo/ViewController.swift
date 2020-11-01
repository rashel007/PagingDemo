//
//  ViewController.swift
//  PagingDemo
//
//  Created by Estique Ahmed on 1/11/20.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var data = [String]()
    //
    let apiService = APIServic()
    
     private let tableview: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tb
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        
        apiService.fetchData(pagination: false) { [weak self] (result) in
            switch(result) {
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            case .failure(_):
                break
            }
        }
        
    }
    
    func addFooterLoadingView () -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !apiService.isFetchingData else {
            print("Alreading in fetching")
            return
        }
        
        let position = scrollView.contentOffset.y
        let tableViewContentSize = tableview.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        tableview.tableFooterView = addFooterLoadingView()
       
        if position > tableViewContentSize - 100 - scrollViewHeight {
            apiService.fetchData(pagination: true) { [weak self] (result) in
                
                DispatchQueue.main.async {
                    self?.tableview.tableFooterView = nil
                }
                
                switch(result) {
                case .success(let data):
                    self?.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self?.tableview.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }


}

