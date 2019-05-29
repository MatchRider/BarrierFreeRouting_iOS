//
//  MapController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 20/08/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import Foundation
import WebKit
import CoreLocation
enum MapType {
    case route
    case suggestion
}
protocol MapViewDelegate:class {
    func didTapped(onWay way:WayData)
    func didTapped(onNode node:NodeReference)
    func didEndMapDrag(withCenter center:[Double])
    func didStartMapDrag()
    func mapViewDidLoad()
    func didChangeMapZoomLevel(zoomLevel: Double)
}
class MapView : WKWebView
{
    var wayOSMData : [WayData]! = []
    var validatedWayOSMData = [WayData]()
    var inValidatedOSMData = [WayData]()
    
    var nodeOSMData : [NodeReference]! = []
    var validatedNodeOSMData = [NodeReference]()
    var inValidatedNodeOSMData = [NodeReference]()
   
    var currentLocation = LocationServiceManager.sharedInstance.currentLocation?.coordinate
   
    var currentZoomLevel = 13
    var isFirstTime = true
    var mapType : MapType = .route
    
    weak var delegate : MapViewDelegate?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration = WKWebViewConfiguration()) {
        super.init(frame: frame, configuration: configuration)
        
        self.navigationDelegate = self
        self.uiDelegate = self
        
        LocationServiceManager.sharedInstance.viewDelegate = self
        
        /// Read HTML from the "Leaflet.html" and render on the MapView
        let htmlFile    = Bundle.main.path(forResource: "Leaflet", ofType: "html")
        let html        = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        let path        = Bundle.main.bundlePath
        let baseURL     = URL.init(fileURLWithPath: path)
        
        loadHTMLString(html!, baseURL: baseURL)
        
        configuration.userContentController.add(self, name: AppConstants.LeafletEvents.POLYLINE_TAPPED)
         configuration.userContentController.add(self, name: AppConstants.LeafletEvents.NODE_TAPPED)
        configuration.userContentController.add(self, name: AppConstants.LeafletEvents.MAP_MOVE_END_EVENT)
        configuration.userContentController.add(self, name: AppConstants.LeafletEvents.MAP_MOVE_START_EVENT)
         configuration.userContentController.add(self, name: AppConstants.LeafletEvents.MAP_ZOOM_LEVEL_CHANGED)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView
{
    func initialiseWayInfo(withWayData wayData:[WayData])
    {
        self.wayOSMData = wayData
        for index in self.wayOSMData.indices
        {
            let objWay = self.wayOSMData[index]
            objWay.coordinatesDouble = objWay.coordinatesData?.map({ (obj) -> [Double] in
                if obj.count == 2
                {
                    return [Double(obj[0])!,Double(obj[1])!]
                }
                return []
            })
        }
        self.validatedWayOSMData = wayData.filter({ (objWay) -> Bool in
            return objWay.isValid! == "true"
        })
        self.inValidatedOSMData = wayData.filter({ (objWay) -> Bool in
            return objWay.isValid! == "false"
        })
        
    }
    func initialiseNodeInfo(withNodeData nodeData:[NodeReference])
    {
        self.nodeOSMData = nodeData
        self.validatedNodeOSMData = nodeData.filter({ (objNode) -> Bool in
            if let attributes = objNode.attributes,attributes.count > 0 {
                 return attributes[0].isValid! == "true"
            }
            return false
        })
        self.inValidatedNodeOSMData = nodeData.filter({ (objNode) -> Bool in
            if let attributes = objNode.attributes,attributes.count > 0 {
                return attributes[0].isValid! == "false"
            }
            return false
        })
        
    }
    func showNodeData(ofType type : Int,withColor color:String)
    {
        self.removeAllLayers()
        var allLatLongs = [[Double]]()
        switch type
        {
        case 0:

            break
        case 1:
            for (_,node) in self.inValidatedNodeOSMData.enumerated()
            {
                if let lat = node.lat?.toDouble,let long = node.lon?.toDouble
                {
                    
                    self.addNodeMarker(withLatitude: lat, longitude: long)
                    allLatLongs.append( [lat,long])
                }
                
            }
            break
        case 2:
            for (_,node) in self.validatedNodeOSMData.enumerated()
            {
                if let lat = node.lat?.toDouble,let long = node.lon?.toDouble
                {
                    self.addValidatedNodeMarker(withLatitude: lat, longitude: long)
                    allLatLongs.append( [lat,long])
                }
                
            }
            break
        default: break
        }

       
       // self.boundMap(withLatLongs: allLatLongs, withPadding: [5,5])
        self.currentZoomLevel = 15
        self.setMapZoom(withZoomLevel:15)
        let lat = currentLocation?.latitude ?? 0.0
        let long = currentLocation?.longitude ?? 0.0
        self.addUserMarkerOnMap(withLatitude: lat, longitude: long)
    }
    func showWayData(ofType type : Int,withColor color:String)
    {
        self.removeAllLayers()
        var allLatLongs = [[Double]]()
        var selectedData = [WayData]()
        switch type
        {
        case 0:
            selectedData = self.wayOSMData
            break
        case 1:
            selectedData = self.inValidatedOSMData
            break
        case 2:
            selectedData = self.validatedWayOSMData
            break
        default: break
        }
        
        for index in selectedData.indices
        {
            let objWay = selectedData[index]
            
            if let coordinates = objWay.coordinatesDouble
            {
                let latlongs = coordinates[0...(coordinates.count)-1]
                self.drawPolyLine(withLatLongs:latlongs  , andColor: objWay.color!, withPadding: [5,5],shouldTap: true)
                
                let latlong = coordinates[0...(coordinates.count)-1].map({$0})
                allLatLongs.append(contentsOf: latlong)
            }
            
        }
        self.boundMap(withLatLongs: allLatLongs, withPadding: [5,5])
        self.currentZoomLevel = 15
        self.setMapZoom(withZoomLevel:15)
        let lat = currentLocation?.latitude ?? 0.0
        let long = currentLocation?.longitude ?? 0.0
        self.addUserMarkerOnMap(withLatitude: lat, longitude: long)
    }
}

extension MapView : WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate
{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case AppConstants.LeafletEvents.POLYLINE_TAPPED:
            let arrayLatLong = ((message.body as! NSArray).map({ (obj) -> [Double] in
                let lat = (obj as! NSDictionary)["lat"] as? Double ?? 0.0
                let long = (obj as! NSDictionary)["lng"] as? Double ?? 0.0
                return [lat,long]
            }))
            print(arrayLatLong)
            let arry =  self.wayOSMData.filter({ (obj) -> Bool in
                return (obj.coordinatesDouble?.elementsEqual(arrayLatLong, by: { (obj1, obj2) -> Bool in
                    return obj1[0] == obj2[0] && obj1[1] == obj2[1]
                }))!
            })
            let wayObject = arry.count != 0 ? arry[0] : nil
            if let wayObj = wayObject,wayObj.osmWayId != nil
            {
                self.delegate?.didTapped(onWay: wayObj)
            }
                break
        case AppConstants.LeafletEvents.NODE_TAPPED:
            let arrayLatLong = message.body as! [String:Double]
            let nodes =  self.nodeOSMData.filter({ (obj) -> Bool in
                return obj.lat?.toDouble == arrayLatLong["lat"] && obj.lon?.toDouble == arrayLatLong["lng"]
            })
            if nodes.count > 0
            {
                self.delegate?.didTapped(onNode: nodes[0])
            }
            break
        case AppConstants.LeafletEvents.MAP_MOVE_END_EVENT:
            if mapType == .route {
            let arrayLatLong = message.body as! [String:Double]
            self.delegate?.didEndMapDrag(withCenter: [arrayLatLong["lat"]!,arrayLatLong["lng"]!])
            }
            break
        case AppConstants.LeafletEvents.MAP_MOVE_START_EVENT:
              if mapType == .route {
            self.delegate?.didStartMapDrag()
            }
            break
        case AppConstants.LeafletEvents.MAP_ZOOM_LEVEL_CHANGED:
          self.delegate?.didChangeMapZoomLevel(zoomLevel: (message.body as! Double))
            break
        default: break
        }
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
      //  (UIApplication.shared.visibleViewController as? MapScreenViewController)?.showErrorAlert("", alertMessage: message)
        completionHandler()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let lat = currentLocation?.latitude ?? 0.0
        let long = currentLocation?.longitude ?? 0.0
        currentZoomLevel = 18
        setMapView(withLatitude: lat, longitude: long, andZoom: 18)
        addUserMarkerOnMap(withLatitude: lat, longitude: long)
        
        if mapType == .suggestion
        {
        self.delegate?.mapViewDidLoad()
        }
    }
}
extension MapView:LocationUpdateDelegate
{
    func locationUpdated(lat: Double, long: Double)
    {
        self.currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        if isFirstTime
//        {
//            self.setMapView(withLatitude: lat, longitude: long, andZoom: 18)
//            isFirstTime = false
//        }
//        else {
            self.changePositionOfMarker(withLatitude: lat, longitude: long)
      //  }
        
    }
}
