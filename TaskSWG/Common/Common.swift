//
//  Common.swift
//  TaskSW
//  Created by Apple on 09/09/22.
//
import UIKit
import Foundation

//MARK:- ShowLoader
class common{
    
    static let sharedInstance = common()
    private init(){}
    
    
    var sharedlocation = "chennai"
    let fonttitle = UIFont(name: "Helvetica-Bold", size: 24.0)
    let font = UIFont(name: "Helvetica-Bold", size: 16.0)
    
    internal func createActivityIndicator(_ uiView : UIView)->UIView{
        
        let container: UIView = UIView(frame: CGRect.zero)
        container.layer.frame.size = uiView.frame.size
        container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
        container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.backgroundColor = .lightGray//UIColor(white:0.1, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.layer.shadowRadius = 5
        loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
        loadingView.layer.opacity = 2
        loadingView.layer.masksToBounds = false
        loadingView.layer.shadowColor = UIColor.gray.cgColor
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.clipsToBounds = true
        actInd.style = UIActivityIndicatorView.Style.large
        
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        container.isHidden = true
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return container
        
    }
    func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
        
        var currHeight:CGFloat!
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        currHeight = label.frame.height
        label.removeFromSuperview()
        
        return currHeight
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func convertdateFormat(data: String) -> String{
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = df.date(from: data)
        let df1 = DateFormatter()
        df1.dateFormat = "EEEE"
        let val = df1.string(from: dateString ?? Date())
        return "\(String(describing: val))"
    }
    
    
}
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
public enum StatusCodeType {
    case informational, successful, redirection, clientError, serverError, cancelled, unknown
}
