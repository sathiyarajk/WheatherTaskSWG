//
//  Extension-ViewController.swift
//  TaskSWG
//
//  Created by Apple on 09/09/22.
//


import Foundation
import CoreLocation
import UIKit
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        guard let location = locations.last else { return }
        
        _ = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        //Note: Get Locaiton details
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            if let placemark = placemarks{
            if placemark.count>0{
                guard let placemark = placemarks?[0] else{ return }
                
                DispatchQueue.main.async {
                    self.cityLbl.text = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                }
                common.sharedInstance.sharedlocation = placemark.locality ?? ""
                self.fetchResponse()
                self.locationManager.stopUpdatingLocation()
            }
            }
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return self.wheather?.forecast?.forecastday?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WhetherListTableViewCell

        cell?.lblDay.text = common.sharedInstance.convertdateFormat(data: (self.wheather?.forecast?.forecastday?[indexPath.row].hour?[indexPath.row].time) ?? "")
       
        cell?.backgroundColor = UIColor.clear
        let img: String = String(self.wheather?.forecast?.forecastday?[indexPath.row].day?.condition?.icon?.dropFirst(2) ?? "")
        cell?.imgWhether.image = common.sharedInstance.resizeImage(image: UIImage(url: URL(string: "https://\(img)")) ?? UIImage() , targetSize: CGSize(width: 40, height: 40.0))
        let minmaxValue = "\(String(describing: self.wheather?.forecast?.forecastday?[indexPath.row].day?.mintemp_c ?? 0.0))C - \(String(describing: self.wheather?.forecast?.forecastday?[indexPath.row].day?.maxtemp_c ?? 0.0))C"
       
        cell?.lblMinWhether.text =  minmaxValue
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
  
}
