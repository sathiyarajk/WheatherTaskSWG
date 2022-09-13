//
//  ViewController.swift
//  TaskSWG
//
//  Created by Apple on 08/09/22.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    
    private lazy var  loader =
    {
        return common.sharedInstance.createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
    }()
    
    
    private let fetcher = ResponseFetcher()
    var locationManager:CLLocationManager!
    var cityLbl = UILabel()
    var currentDateLbl = UILabel()
    let tableView: UITableView = UITableView()
    var wheather : Wheather? = nil
    let whetherimagecurrentLocation = UIImageView()
    let currentWheatherstatus = UILabel()
    let cityInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(WhetherListTableViewCell.self, forCellReuseIdentifier: "cell")
        intialLoads()
        
    }
    
    private func intialLoads()
    {
        
        authorizeMap()
        loadcurrentdate()
        setLayout()
        setFonttextColor()
    }
    
    private func authorizeMap(){
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    private func loadcurrentdate(){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd MMM YYYY HH:MM"
        let dateString = df.string(from: date)
        currentDateLbl.text = dateString
        
    }
    
    
    private func setLayout(){
        let imageName = "756a72bd9b91af6ee5509021090fa474"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        view.addSubview(imageView)
        
        //enable auto layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        currentDateLbl.translatesAutoresizingMaskIntoConstraints = true
        cityInfoView.translatesAutoresizingMaskIntoConstraints = true
        whetherimagecurrentLocation.translatesAutoresizingMaskIntoConstraints = true
        currentWheatherstatus.translatesAutoresizingMaskIntoConstraints = true
        tableView.translatesAutoresizingMaskIntoConstraints = true
        
        imageView.addSubview(cityInfoView)
        
        cityInfoView.translatesAutoresizingMaskIntoConstraints = false
        cityInfoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cityInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cityInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cityInfoView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.4).isActive = true
        
        
        cityLbl.textAlignment = .center
        cityLbl.tintColor = .black
        self.cityInfoView.addSubview(cityLbl)
        
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 50).isActive = true
        cityLbl.widthAnchor.constraint(equalTo: cityLbl.widthAnchor).isActive = true
        cityLbl.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        currentDateLbl.textAlignment = .center
        currentDateLbl.tintColor = .black
        self.cityInfoView.addSubview(currentDateLbl)
        
        
        currentDateLbl.translatesAutoresizingMaskIntoConstraints = false
        currentDateLbl.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: 10).isActive = true
        currentDateLbl.leadingAnchor.constraint(equalTo: cityLbl.leadingAnchor).isActive = true
        currentDateLbl.widthAnchor.constraint(equalTo: cityLbl.widthAnchor).isActive = true
        currentDateLbl.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        self.cityInfoView.addSubview(whetherimagecurrentLocation)
        
        
        whetherimagecurrentLocation.translatesAutoresizingMaskIntoConstraints = false
        whetherimagecurrentLocation.topAnchor.constraint(equalTo: currentDateLbl.bottomAnchor, constant: 10).isActive = true
        whetherimagecurrentLocation.widthAnchor.constraint(equalToConstant: 40).isActive = true
        whetherimagecurrentLocation.heightAnchor.constraint(equalToConstant: 40).isActive = true
        whetherimagecurrentLocation.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        self.cityInfoView.addSubview(currentWheatherstatus)
        currentWheatherstatus.translatesAutoresizingMaskIntoConstraints = false
        currentWheatherstatus.textAlignment = .center
        currentWheatherstatus.topAnchor.constraint(equalTo: whetherimagecurrentLocation.bottomAnchor, constant: 10).isActive = true
        currentWheatherstatus.widthAnchor.constraint(equalTo: cityLbl.widthAnchor).isActive = true
        currentWheatherstatus.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: currentWheatherstatus.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        
    }
    func setFonttextColor(){
        
        self.cityLbl.font = common.sharedInstance.fonttitle
        self.currentWheatherstatus.font = common.sharedInstance.fonttitle
        self.currentDateLbl.font = common.sharedInstance.fonttitle
        
        self.cityLbl.textColor = .white
        self.currentWheatherstatus.textColor = .white
        self.currentDateLbl.textColor = .white
    }
    
    
    
    //MARK: - Fetching Response
    
    func fetchResponse() {
        
        self.loader.isHidden = false
        fetcher.fetchRepos(completion: { [weak self] repos in
            self?.wheather = repos
            print(repos)
            DispatchQueue.main.async
            {
                self?.loader.isHidden = true
                self?.tableView.reloadData()
            }
            self?.setcurrentWheatherimg()
        })
    }
    
    func setcurrentWheatherimg(){
        let val: String = String(self.wheather?.current?.condition?.icon?.dropFirst(2) ?? "")
        DispatchQueue.main.async {
            self.whetherimagecurrentLocation.image  = common.sharedInstance.resizeImage(image: UIImage(url: URL(string: "https://\(val)")) ?? UIImage() , targetSize: CGSize(width: 40, height: 40.0))
            self.currentWheatherstatus.text = self.wheather?.current?.condition?.text ?? ""
        }
    }
    
}

