//
//  SearchVC+Ext.swift
//  Watchify
//
//  Created by User on 13/12/22.
//

import Foundation
import UIKit


extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, SearchResultViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier,for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: titleViewModel(titleName: titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown", posterUrl: titles[indexPath.row].poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else{
            return
        }
        resultsController.delegate = self
        APICaller.shared.search(with: query) { result in
                switch result{
                case .success(let titles):
                    DispatchQueue.main.async {
                        resultsController.titles = titles
                        resultsController.searchResultCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
              
    }
    
    func searchResultViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
