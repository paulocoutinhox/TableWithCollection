import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "TableViewCell"
    
    private var tableView: UITableView!
    private var listData: [ListItem]?
    
    func createAll() {
        // table view
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(tableView)
        
        // button: submit
        let rightButton = UIBarButtonItem(image: UIImage(named: "IcoReload"), style: .plain, target: self, action: #selector(onRightButtonAction))
        navigationItem.rightBarButtonItem = rightButton
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func layoutAll() {
        // table view
        view.addConstraint(NSLayoutConstraint(item: tableView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: tableView!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0))
    }
    
    func loadData() {
        listData = [ListItem]()
        
        for x in 0..<20 {
            var items = [CollectionItem]()
            
            for y in 0..<10 {
                items.append(CollectionItem(title: "Category \(x+1)\nItem \(y+1)", color: randomColor()))
            }
            
            listData?.append(ListItem(title: "Category \(x+1)", items: items))
        }
        
        refreshData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        if let item = listData?[indexPath.row] {
            print("Category rendered: \(item.title)")
            
            cell.bind(tag: indexPath.row, title: item.title, listData: item.items)
            cell.tag = indexPath.row
            
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = UIColor.white
        
        createAll()
        layoutAll()
        loadData()
    }
    
    func refreshData() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    func randomColor() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    @objc func onRightButtonAction(button: UIBarButtonItem) {
        refreshData()
    }
    
}

