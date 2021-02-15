//
//  ListTableViewController.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit

class ListTableViewController: UITableViewController{

    @IBOutlet var listTableView: UITableView!
    @IBOutlet weak var listSearchBar: UISearchBar!
    @IBOutlet weak var azFilterButton: UIBarButtonItem!
    
    var AZfilter =  true
    var searchMode : Bool = false
    var paginationEnable = true
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager().getPeople(page: page, closure: { finish in
            self.azFilter()
            self.listTableView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.listTableView.reloadData()
    }

    @IBAction func azFilterButtonTapped(_ sender: UIBarButtonItem) {
        azFilter()
    }
    
    func azFilter(){
        if AZfilter{
            AZfilter = false
            azFilterButton.image = UIImage(named: "filterZA")
            DataManager.shared.allPeople = DataManager.shared.allPeople.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
        }else{
            AZfilter = true
            azFilterButton.image = UIImage(named: "filterAZ")
            DataManager.shared.allPeople = DataManager.shared.allPeople.sorted { $1.name!.lowercased() < $0.name!.lowercased() }
        }
        listTableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchMode{
            return DataManager.shared.searchedPeople.count
        }else{
            return DataManager.shared.allPeople.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        if searchMode{
            cell.setCell(person: DataManager.shared.searchedPeople[indexPath.row])
        }else{
            cell.setCell(person: DataManager.shared.allPeople[indexPath.row])
        }
        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var person : PersonModel
        if searchMode{
            person = DataManager.shared.searchedPeople[indexPath.row]
        }else{
            person = DataManager.shared.allPeople[indexPath.row]
        }
        goToDetail(person: person)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row > DataManager.shared.allPeople.count - 2) && paginationEnable && !searchMode{
            print("last")
            page = page + 1
            ApiManager().getPeople(page: page, closure: {finish in
                if finish{
                    self.paginationEnable = false
                }
                self.listTableView.reloadData()
            })
        }
    }
    
    
    func goToDetail(person : PersonModel){
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailViewController") as! DetailViewController
        detail.person = person
        present(detail, animated: true, completion: nil)
    }

   

}



extension ListTableViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchMode{
            DataManager.shared.searchedPeople.removeAll()
            ApiManager().searchPeopleWithName(searchBar.text!) {
                self.listTableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0{
            searchMode = true
            azFilterButton.isEnabled = false
        }else{
            searchMode = false
            azFilterButton.isEnabled = true
            self.listTableView.reloadData()
        }
    }
}
