//
//  GridViewController.swift
//  TestSL
//
//  Created by Giulio Mignemi on 15/02/21.
//

import UIKit

class GridViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    var searchMode : Bool = false
    var paginationEnable = true
    var page = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        gridCollectionView.reloadData()
    }
    
}



extension GridViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchMode{
            return DataManager.shared.searchedPeople.count
        }else{
            return DataManager.shared.allPeople.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gridCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
        if searchMode{
            cell.setCell(person: DataManager.shared.searchedPeople[indexPath.row])
        }else{
            cell.setCell(person: DataManager.shared.allPeople[indexPath.row])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            let widthScreen = UIScreen.main.bounds.size.width
            let widthSize = (widthScreen/4) - 20
            return CGSize(width: widthSize, height: 200)
        }else{
            let widthScreen = UIScreen.main.bounds.size.width
            let widthSize = (widthScreen/2) - 20
            return CGSize(width: widthSize, height: 160)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        gridCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var person : PersonModel
        if searchMode{
            person = DataManager.shared.searchedPeople[indexPath.row]
        }else{
            person = DataManager.shared.allPeople[indexPath.row]
        }
        goToDetail(person: person)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row > DataManager.shared.allPeople.count - 2) && paginationEnable && !searchMode{
            print("last")
            page = page + 1
            ApiManager().getPeople(page: page, closure: {finish in
                if finish{
                    self.paginationEnable = false
                }
                self.gridCollectionView.reloadData()
            })
        }
    }
    
    func goToDetail(person : PersonModel){
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailViewController") as! DetailViewController
        detail.person = person
        present(detail, animated: true, completion: nil)
    }

}


extension GridViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchMode{
            DataManager.shared.searchedPeople.removeAll()
            ApiManager().searchPeopleWithName(searchBar.text!) {
                self.gridCollectionView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0{
            searchMode = true
        }else{
            searchMode = false
            self.gridCollectionView.reloadData()
        }
    }
}
