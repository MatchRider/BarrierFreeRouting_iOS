//
//  PlacesPresenter.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 10/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
class PlacesPresenter: ResponseCallback{
    
    //MARK:- MapPresenter local properties
    private weak var placesViewDelegate             : PlacesViewDelegate?
    private var shouldShowLoaderOnScreen = true
    private  var type : MapRequestModel.QueryType!
    //MARK:- Constructor
    init(delegate responseDelegate:PlacesViewDelegate) {
        self.placesViewDelegate = responseDelegate
    }
    
    
    
    //MARK:- ResponseCallback delegate methods
    
    func servicesManagerSuccessResponse<T:Mappable> (responseObject : T){
        
        self.placesViewDelegate?.hideLoader()
        if responseObject is PlacesResponseModel && self.type == MapRequestModel.QueryType.query {
            self.placesViewDelegate?.didReceivePlacesSuggestion(withResponseModel: responseObject as! PlacesResponseModel)
        }
        if responseObject is PlacesResponseModel && self.type == MapRequestModel.QueryType.location {
            self.placesViewDelegate?.didReceiveAddress(withResponseModel: responseObject as! PlacesResponseModel)
        }
    }
    
    func servicesManagerError(error : AnyObject){
        self.placesViewDelegate?.hideLoader()
        if let errorObject = Mapper<WayError>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: error)),let errorMessage = errorObject.message
        {
            self.placesViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: errorMessage)
        }
        else if let errorObject = Mapper<PlacesResponseModel>().map(JSONString: ServiceManager.getJsonStringFor(dictionary: error)),let errorMessage = errorObject.geocoding?.errors,errorMessage.count != 0
        {
            self.placesViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: errorMessage[0])
        }
        else
        {
            self.placesViewDelegate?.showErrorAlert(AppConstants.ErrorMessages.ALERT_TITLE, alertMessage: AppConstants.ErrorMessages.SOME_ERROR_OCCURED)
        }
        
        
    }
    
    
    //MARK:- Methods to call server
    
    /**
     This method is used to send places request to business layer with valid Request model
     - returns : Void
     */
    func sendPlacesRequest(withUserInput query:String,type : MapRequestModel.QueryType) -> Void{
        // self.placesViewDelegate?.showLoader()
        self.type = type
        var placesRequestModel : MapRequestModel!
        placesRequestModel = MapRequestModel.Builder()
            .addRequestHeader(key: "Content-Type", value:"application/json").setQuery(query).setQueryType(type)
            .build()
         MapAPIRequest().makeAPIRequestForPlaces(withReqFormData: placesRequestModel, responseCallback: self)
    }
    
    
    func getAddressFromProperties(_ properties:PlacesProperties)->String
    {
        var address = ""
        var name = ""
        var houseNumber = ""
        var street = ""
        var locality = ""
        var region = ""
        var country = ""
        
        if let propertyName = properties.name
        {
            name = propertyName + " "
        }
        if let propertyHouseNo = properties.housenumber
        {
            houseNumber = propertyHouseNo + " "
        }
        if let propertyStreet = properties.street
        {
            street = propertyStreet + " "
        }
        if let propertyLocality = properties.locality
        {
            locality = propertyLocality + " "
        }
        if let propertyRegion = properties.region
        {
            region = propertyRegion + " "
        }
        if let propertyCountry = properties.country
        {
            country = propertyCountry + " "
        }
        
        address = name+houseNumber+street+locality+region+country
        
        return address
    }
}
