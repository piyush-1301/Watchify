//
//  DownloadsViewController.swift
//  Watchify
//
//  Created by User on 08/12/22.
//

import UIKit

class DownloadsViewController: UIViewController {

    var titles: [TitleItem] = [TitleItem]()
    
    private let downloadedTable: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(downloadedTable)
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        // Do any additional setup after loading the view.
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }

    private func fetchLocalStorageForDownload(){
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { results in
        switch results{
        case .success(let titles):
            self.titles = titles
            self.downloadedTable.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        }
        }
    }
}
