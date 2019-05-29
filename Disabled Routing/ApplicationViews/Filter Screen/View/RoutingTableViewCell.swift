//
//  RoutingTableViewCell.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 10/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
protocol RouteViaDelegate:class {
    func didSelectRoutePoint(_ routeInfo:(String,Double,Double))
}
class RoutingTableViewCell: UITableViewCell {
    @IBOutlet weak var textFieldRouteWia: CustomLocationSearchTextField!
    @IBOutlet weak var tableViewPlaces: UITableView!
    var routeViaPlacesResponseModel : PlacesResponseModel!
    weak var delegate : RouteViaDelegate!
    var presenterPlaces : PlacesPresenter!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenterPlaces = PlacesPresenter(delegate: self)
        self.textFieldRouteWia.customDelegate = self
        
        self.tableViewPlaces.estimatedRowHeight = 30
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
extension RoutingTableViewCell : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let placesModel = self.routeViaPlacesResponseModel,let features = placesModel.features,features.count != 0 else
        {
            return 0
        }
        return features.count
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return Int(ScreenSize.size.width) == ScreenWidth.Iphone5 ? self.tableViewPlaces.frame.height/3 : self.tableViewPlaces.frame.height/4
//
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellIdentifier")
        cell.textLabel?.text = self.routeViaPlacesResponseModel.features?[indexPath.row].properties?.name
        cell.textLabel?.font = UIFont.getFrutigerLight(withSize: 17)
        cell.detailTextLabel?.text =  self.presenterPlaces.getAddressFromProperties((self.routeViaPlacesResponseModel.features?[indexPath.row].properties)!)
        cell.detailTextLabel?.font = UIFont.getFrutigerLight(withSize: 14)
        cell.detailTextLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = self.routeViaPlacesResponseModel.features?[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        self.textFieldRouteWia.text = cell?.detailTextLabel?.text
        
        let routeAddress = cell?.detailTextLabel?.text ?? ""
        let fromLat = feature?.geometry?.coordinates![1] ?? 0.0
        let fromLong = feature?.geometry?.coordinates![0] ?? 0.0
        self.delegate.didSelectRoutePoint((routeAddress, fromLat, fromLong))
        self.tableViewPlaces.isHidden = true
        
    }
}
extension RoutingTableViewCell : PlacesViewDelegate
{
    func didReceivePlacesSuggestion(withResponseModel directionsResponseModel: PlacesResponseModel) {
        self.routeViaPlacesResponseModel = directionsResponseModel
        self.tableViewPlaces.isHidden = false
        
        if let _ = tableViewPlaces.delegate
        {
            self.tableViewPlaces.reloadData()
        }
        else
        {
            self.tableViewPlaces.delegate = self
            self.tableViewPlaces.dataSource = self
            self.tableViewPlaces.reloadData()
        }
    }
    
    func didReceiveAddress(withResponseModel directionsResponseModel: PlacesResponseModel) {
        guard let features = directionsResponseModel.features,features.count > 0 else
        { return }
        
        guard let properties =  features[0].properties else { return }
        
        let address = self.presenterPlaces.getAddressFromProperties(properties)

        self.textFieldRouteWia.text = address
        
        let routeAddress = address
        let currentLocation = LocationServiceManager.sharedInstance.currentLocation?.coordinate
        let fromLat = currentLocation?.latitude ?? 0.0
        let fromLong = currentLocation?.longitude ?? 0.0
        self.delegate.didSelectRoutePoint((routeAddress, fromLat, fromLong))
    }
    
    func showLoader() {}
    func hideLoader() {}
    func showErrorAlert(_ alertTitle: String, alertMessage: String) {}
}
extension RoutingTableViewCell:CustomLocationSearchTextFieldDelegate
{
    func didTextFieldBecomeActive() {}
    
    func sendPlacesRequest(withUserInput: String, type: MapRequestModel.QueryType) {
        if removeQueryParameter(forUserInput: withUserInput).count <= 2 && type == .query {
            self.tableViewPlaces.isHidden = true
            return
        }
        self.presenterPlaces.sendPlacesRequest(withUserInput: withUserInput, type: type)
    }
    private func removeQueryParameter(forUserInput userInput:String)->String
    {
        let queryParams = userInput.components(separatedBy: "&")
        if queryParams.count != 0
        {
            return queryParams[0].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return ""
    }
}
