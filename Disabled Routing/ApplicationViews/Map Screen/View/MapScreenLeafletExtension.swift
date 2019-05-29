//
//  MapScreenLeafletExtension.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 23/04/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import WebKit
import Polyline
import CoreLocation

extension WKWebView {
    func setMapView(withLatitude lat:Double,longitude long:Double,andZoom zoom:Int)
    {
        self.evaluateJavaScript(("setMapView(\(lat),\(long),\(zoom))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }// map.setZoom(0);
    func setMapZoom(withZoomLevel zoom:Int)
    {
        self.evaluateJavaScript(("setMapZoom(\(zoom))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addNavigationMarkerOnMap(withLatitude lat:Double,longitude long:Double)
    {
        self.evaluateJavaScript(("addNavigationMarkerOnMap(\(lat),\(long))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func changePositionOfMarker(withLatitude lat:Double,longitude long:Double)
    {
        self.evaluateJavaScript(("changePositionOfMarker(\(lat),\(long))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func changeColorOfPolyline(ofIndex index:Int)
    {
        self.evaluateJavaScript(("changeColorOfPolyline(\(index))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
            
        }
    }
    func addUserMarkerOnMap(withLatitude lat:Double,longitude long:Double)
    {
        self.evaluateJavaScript(("addUserMarkerOnMap(\(lat),\(long))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func removeAllLayers()
    {
        self.evaluateJavaScript(("removeAllLayers()")) { (obj, error) in
            print(error?.localizedDescription ?? "")
            print(obj.debugDescription )
        }
    }
    func drawPolyLine(withLatLongs partialLatLongs:ArraySlice<[Double]>,andColor color:String,withPadding padding:[Int],shouldTap:Bool)
    {
        self.evaluateJavaScript(("drawPolyline(\(partialLatLongs),\'\(color)\',\(padding),\(shouldTap))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func removeNodes()
    {
        self.evaluateJavaScript(("removeNodes()")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func showNodes()
    {
        self.evaluateJavaScript(("showNodes()")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addNodeMarker(withLatitude lat:Double,longitude long:Double)
    {
        self.evaluateJavaScript(("addNodeMarker(\(lat),\(long))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addValidatedNodeMarker(withLatitude lat:Double,longitude long:Double)
    {
        self.evaluateJavaScript(("addValidatedNodeMarker(\(lat),\(long))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addSourceMarkerOnMap(withLatitude lat:Double,longitude long:Double,address:String)
    {
        self.evaluateJavaScript(("addSourceMarkerOnMap(\(lat),\(long),\'\(address)\')")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addMidPointMarkerOnMap(withLatitude lat:Double,longitude long:Double,address:String)
    {
        self.evaluateJavaScript(("addMidPointMarkerOnMap(\(lat),\(long),\'\(address)\')")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addDestinationMarkerOnMap(withLatitude lat:Double,longitude long:Double,address:String)
    {
        self.evaluateJavaScript(("addDestinationMarkerOnMap(\(lat),\(long),\'\(address)\')")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func boundMap(withLatLongs latLngs:[[Double]],withPadding padding:[Int])
    {
        self.evaluateJavaScript(("boundMap(\(latLngs),\(padding))")) { (obj, error) in
            print(error?.localizedDescription ?? "")
        }
    }
    func addNodeMarkers(withFunctionName funcName:String,andLatitude lat:Double,longitude long:Double)
    {
        //        self.evaluateJavaScript(("\(funcName)(\(lat),\(long),'\(node.wheelchair!.capitalizeWordsInSentence())','\(publicTranferName)')")) { (obj, error) in
        //            print(error?.localizedDescription ?? "")
        //        }
        
    }
}
