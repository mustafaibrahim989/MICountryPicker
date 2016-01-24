//
//  MICountryPicker.swift
//  MICountryPicker
//
//  Created by Ibrahim, Mustafa on 1/24/16.
//  Copyright © 2016 Mustafa Ibrahim. All rights reserved.
//

import UIKit

class MICountry: NSObject {
    let name: String
    let code: String
    var section: Int?
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}

struct Section {
    var countries: [MICountry] = []
    
    mutating func addCountry(country: MICountry) {
        countries.append(country)
    }
}

class MICountryPicker: UITableViewController {
    
    private var searchController: UISearchDisplayController!
    private var filteredList = [MICountry]()
    private var unsourtedCountries : [MICountry] {
        let locale = NSLocale.currentLocale()
        var unsourtedCountries = [MICountry]()
        let countriesCodes = NSLocale.ISOCountryCodes()
        
        for countryCode in countriesCodes {
            let displayName = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode)
            let country = MICountry(name: displayName!, code: countryCode)
            unsourtedCountries.append(country)
        }
        
        return unsourtedCountries
    }
    
    private var _sections: [Section]?
    private var sections: [Section] {
        
        if _sections != nil {
            return _sections!
        }
        
        let countries: [MICountry] = unsourtedCountries.map { country in
            let country = MICountry(name: country.name, code: country.code)
            country.section = collation.sectionForObject(country, collationStringSelector: "name")
            return country
        }
        
        // create empty sections
        var sections = [Section]()
        for _ in 0..<self.collation.sectionIndexTitles.count {
            sections.append(Section())
        }
        
        // put each country in a section
        for country in countries {
            sections[country.section!].addCountry(country)
        }
        
        // sort each section
        for section in sections {
            var s = section
            s.countries = collation.sortedArrayFromArray(section.countries, collationStringSelector: "name") as! [MICountry]
        }
        
        _sections = sections
        
        return _sections!
    }
    let collation = UILocalizedIndexedCollation.currentCollation()
        as UILocalizedIndexedCollation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        createSearchBar()
        tableView.reloadData()
    }
    
    // MARK: Methods
    
    private func createSearchBar() {
        if self.tableView.tableHeaderView == nil {
            let theSearchBar = UISearchBar(frame: CGRectMake(0, 0, 320, 40))
            theSearchBar.showsCancelButton = true
            tableView.tableHeaderView = theSearchBar
            
            searchController = UISearchDisplayController(searchBar: theSearchBar, contentsController: self)
            searchController.delegate = self
            searchController.searchResultsDataSource = self
            searchController.searchResultsDelegate = self
            theSearchBar.becomeFirstResponder()
        }
    }
    
    private func filter(searchText: String) -> [MICountry] {
        filteredList.removeAll()
        
        sections.forEach { (section) -> () in
            section.countries.forEach({ (country) -> () in
                let result = country.name.compare(searchText, options: [.CaseInsensitiveSearch, .DiacriticInsensitiveSearch], range: Range(start: searchText.startIndex,
                    end: searchText.endIndex))
                if result == .OrderedSame {
                    filteredList.append(country)
                }
                
            })
        }
        
        return filteredList
    }
}

// MARK: - Table view data source

extension MICountryPicker {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let searchTableView = searchDisplayController {
            if tableView == searchTableView.searchResultsTableView {
                return 1
            } else {
                sections.count
            }
        }
        
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchTableView = searchDisplayController {
            if tableView == searchTableView.searchResultsTableView {
                return filteredList.count
            } else {
                sections[section].countries.count
            }
        }
        return sections[section].countries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tempCell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("UITableViewCell")
        
        if tempCell == nil {
            tempCell = UITableViewCell(style: .Default, reuseIdentifier: "UITableViewCell")
        }
        
        let cell: UITableViewCell! = tempCell
        
        if let searchTableView = searchDisplayController {
            if tableView == searchTableView.searchResultsTableView {
                let country = filteredList[indexPath.row]
                cell.textLabel?.text = country.name
            } else {
                let country = sections[indexPath.section].countries[indexPath.row]
                cell.textLabel?.text = country.name
            }
        } else {
            let country = sections[indexPath.section].countries[indexPath.row]
            cell.textLabel?.text = country.name
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !sections[section].countries.isEmpty {
            return self.collation.sectionTitles[section] as String
        }
        return ""
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return collation.sectionIndexTitles
    }
    
    override func tableView(tableView: UITableView,
        sectionForSectionIndexTitle title: String,
        atIndex index: Int)
        -> Int {
            return collation.sectionForSectionIndexTitleAtIndex(index)
    }
}

// MARK: - Table view delegate

extension MICountryPicker {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

// MARK: - UISearchDisplayDelegate

extension MICountryPicker: UISearchDisplayDelegate {
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        filter(searchDisplayController!.searchBar.text!)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        filter(searchString!)
        return true
    }
}
