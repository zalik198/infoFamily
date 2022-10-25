//
//  ViewController.swift
//  FamilyList
//
//  Created by Shom on 24.10.2022.
//

import UIKit

class InfoViewController: UIViewController, UITextFieldDelegate {
    
    var labelHeaderTitle = "Персональные данные"
    var labelFooterTitle = "Дети (макс. 5)"
    var arrayCells = [String]()
    let idCell = "infoTableViewCell"
    
    //MARK: - Add views
    var labelHeader: UILabel = {
        var labelHeader = UILabel(frame: CGRect(x: 20, y: 0, width: 250, height: 50))
        return labelHeader
    }()
    
    var labelFooter: UILabel = {
        var labelFooter = UILabel(frame: CGRect(x: 20, y: 200, width: 150, height: 50))
        return labelFooter
    }()
    
    var textFieldName: UITextField = {
        let textFieldName = UITextField()
        textFieldName.placeholder = "Имя"
        textFieldName.layer.borderWidth = 1
        textFieldName.layer.cornerRadius = 10
        textFieldName.leftViewMode = .always
        textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textFieldName.frame.height))
        return textFieldName
    }()
    
    var textFieldAge: UITextField = {
        let textFieldAge = UITextField()
        textFieldAge.placeholder = "Возраст"
        textFieldAge.layer.borderWidth = 1
        textFieldAge.layer.cornerRadius = 10
        textFieldAge.leftViewMode = .always
        textFieldAge.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textFieldAge.frame.height))
        return textFieldAge
    }()
    
    //MARK: Initial tableView
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = UIRefreshControl()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        navigationController?.tabBarController?.tabBar.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить ребенка", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Очистить", style: .plain, target: self, action: #selector(cleanTableView))
        
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: idCell)
        
        textFieldName.frame = CGRect(x: 20, y: 50, width: view.bounds.size.width - 36, height: 50)
        textFieldAge.frame = CGRect(x: 20, y: 115, width: view.bounds.size.width - 36, height: 50)
        
        //MARK: Keyboard close in tap view
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //MARK: - Initial alert in first start app
        if isFirstLaunch() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.alertAction()
            }
        }
        
        initialLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addTapped() {
        if arrayCells.count != 5 {
            arrayCells.append("1")
            tableView.reloadData()
            if arrayCells.count == 5 {
                navigationItem.rightBarButtonItem?.isHidden = true
            }
        }
    }
    @objc func cleanTableView() {
        
        //Create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //Create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Очистить данные", style: .default) { action -> Void in
            
            self.arrayCells.removeAll()
            self.textFieldName.text = ""
            self.textFieldAge.text = ""
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem?.isHidden = false
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Отмена", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    //First launch app
    func isFirstLaunch() -> Bool {
        
        if (!UserDefaults.standard.bool(forKey: "launched_before")) {
            UserDefaults.standard.set(true, forKey: "launched_before")
            return true
        }
        return false
    }
    
    //Alert
    func alertAction() {
        let alertController = UIAlertController(title: "Информация!", message: "Удалить ячейки можно с помощью свайпа влево!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - Initial constraints
    func initialLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCells.count
    }
    
    
    
    //MARK: - Cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! InfoTableViewCell
        return cell
    }
    
    
    //MARK: - HeaderView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150))
        labelFooter.text = labelFooterTitle
        labelHeader.text = labelHeaderTitle
        
        newView.addSubview(labelHeader)
        newView.addSubview(labelFooter)
        newView.addSubview(textFieldName)
        newView.addSubview(textFieldAge)
        
        return newView
    }
    
    //MARK: - Edit and deleting cells
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if arrayCells.count <= 5 {
                navigationItem.rightBarButtonItem?.isHidden = false
            }
            arrayCells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
}

