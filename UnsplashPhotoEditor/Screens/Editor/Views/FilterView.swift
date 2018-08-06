import UIKit


class FilterView: ModificationView {
    let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    override func setupView() {
        super.setupView()
        
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        addConstraints([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .minimumMargin),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 150),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -.minimumMargin)
        ])
    }
}
