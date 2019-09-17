//
//  UIImageExtension.swift
//  TrueNorth
//
//  Created by Valentin Titov on 10.09.16.
//  Copyright © 2016 Titov Valentin. All rights reserved.
//

import UIKit

enum ImageType : String {
    case jpg, png
}

fileprivate let kDefaultDownsampleSide: CGFloat = 200.0
fileprivate let kSmallSquareSide: CGFloat = 100.0
let kImageExtension: ImageType = ImageType.jpg
let kImageQuality: CGFloat = 1.0

extension UIImage {
    
  var tinted:UIImage { get { return self.withRenderingMode(.alwaysTemplate)} }
  
  static func typedImage(named: String) -> UIImage? {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return UIImage.init(named: "\(named)_iPad")
    }
    return UIImage.init(named: named)
  }
  
  func dataValue() -> Data? {
    switch kImageExtension {
    case .jpg: return self.jpegData(compressionQuality: kImageQuality)
    case .png: return self.pngData()
    }
  }
  
  var aspectRatio:CGFloat {
    get {
      let heightInPoints = self.size.height
      let height = heightInPoints * self.scale
      let widthInPoints = self.size.width
      let width = widthInPoints * self.scale
      let ratio = CGFloat(width/height)
      return ratio
    }
  }
  
  //MARK: Resizing
  func rescaleWith(newWidth:CGFloat) -> UIImage? {
    let oldWidth: CGFloat = size.width
    let scaleFactor: CGFloat = newWidth/oldWidth
    let newHeight: CGFloat = size.height * scaleFactor
    let newWidth: CGFloat = oldWidth * scaleFactor
    UIGraphicsBeginImageContext(CGSize(width: newWidth,
                                       height: newHeight))
    draw(in: CGRect(x: .zero,
                    y: .zero,
                    width: newWidth,
                    height: newHeight))
    if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
      UIGraphicsEndImageContext()
      return newImage
    }
    return nil
  }
  
  func rescaleWith(ratio:CGFloat) -> UIImage? {
    let imageRatio: CGFloat = size.height/size.width
    let newWidth: CGFloat = size.width / ratio
    let newHeight: CGFloat = newWidth * imageRatio
    UIGraphicsBeginImageContext(CGSize(width: newWidth,
                                       height: newHeight))
    draw(in: CGRect(x: .zero,
                    y: .zero,
                    width: newWidth,
                    height: newHeight))
    if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
      UIGraphicsEndImageContext()
      return newImage
    }
    return nil
  }
 
  //MARK: Post string
  static func params(from images:[UIImage]) -> Data? {
    var prepared:[String:String] = [String:String]()
    for i in 0..<images.count {
      let image: UIImage = images[i]
      let base64: String = image.base64String
      prepared["image\(i)"] = base64
    }
    do {
      return try JSONSerialization.data(withJSONObject: prepared, options: .prettyPrinted)
    } catch  {
      print(error)
    }
    return nil
  }
  
//MARK: Base64 String <-> Image
  var base64String : String {
    let imageData:Data?
    switch kImageExtension {
    case .jpg: imageData = self.jpegData(compressionQuality: kImageQuality)
    case .png: imageData = self.pngData()
    }
    if let string = imageData?.base64EncodedString() {
      return string
    }
    return String.empty
  }
    
  static func base64Strings(from images:[UIImage]) -> [String] {
    var base64Strings = [String]()
    for image in images {
      let imageData:Data?
      switch kImageExtension {
      case .jpg:
          imageData = image.jpegData(compressionQuality: kImageQuality)
      case .png:
          imageData = image.pngData()
      }
      if let string = imageData?.base64EncodedString() {
         base64Strings.append(string)
      }
    }
    return base64Strings
  }
  
  static func images(from base64Strings:[String]) -> [UIImage] {
    var images = [UIImage]()
    for string in base64Strings {
        if let image = imageFromBase64(string: string) {
            images.append(image)
        }
    }
    return images
  }
  
  static func imageFromBase64(string:String) -> UIImage? {
    let dataDecoded:NSData = NSData(base64Encoded: string, options: NSData.Base64DecodingOptions(rawValue: 0))!
    return UIImage(data: dataDecoded as Data)
  }
  
  //MARK: Modify
  public func smallSquareImage() -> UIImage? {
    return resizedImage(image: squareImage(),
                        newSize:CGSize.init(width: kSmallSquareSide, height: kSmallSquareSide))
  }
  
  private func resizedImage(image:UIImage, newSize:CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(newSize);
    image.draw(in: CGRect.init(x: .zero,
                               y: .zero,
                               width: newSize.width,
                               height: newSize.height))
    let newImage: UIImage? =  UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    return newImage
  }
  
  func resizeImage(newWidth: CGFloat) -> UIImage? {
    let scale: CGFloat = newWidth / size.width
    let newHeight: CGFloat = size.height * scale
    UIGraphicsBeginImageContext(CGSize.init(width: newWidth,
                                            height: newHeight))
    draw(in: CGRect.init(x: .zero,
                         y: .zero,
                         width: newWidth,
                         height: newHeight))
    let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
  
  public func squareImage() -> UIImage {
    let aspect = self.aspectRatio
    var cropRect:CGRect!
    if aspect < 1.0 { //Crop height
        let newHeight = (size.width * scale)
        let yPosition = ((size.height * scale) - newHeight).half
      switch imageOrientation {
      case .left,.leftMirrored,.right,.rightMirrored:
        cropRect = CGRect.init(x: yPosition,
                               y: .zero,
                               width: size.width * scale,
                               height: newHeight)
      default:
        cropRect = CGRect.init(x: .zero,
                               y: yPosition,
                               width: size.width * scale,
                               height: newHeight)
      }
    } else if aspect >= 1.0 { //Crop width
        let newWidth = (size.height*scale)
        let xPosition = ((size.width * scale) - newWidth).half
      switch imageOrientation {
      case .left,.leftMirrored,.right,.rightMirrored:
        cropRect = CGRect.init(x: .zero,
                               y: xPosition,
                               width: newWidth,
                               height: size.height * scale)
      default:
        cropRect = CGRect.init(x: xPosition,
                               y: .zero,
                               width: newWidth,
                               height: size.height * scale)
      }
    }
    let squareImage = cropped(with: cropRect)
    return squareImage
  }
  
  static func rotate(image:UIImage) -> UIImage? {
    var transform = CGAffineTransform.identity
    switch image.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: .zero)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: .zero, y: image.size.height)
            transform = transform.rotated(by: -CGFloat(Double.pi/2))
        default:
            break
    }
    switch image.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: .zero)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: .zero)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    guard let context = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue) else {
        return nil
    }
    context.concatenate(transform)
    switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(image.cgImage!,
                         in: CGRect(x: .zero, y: .zero, width: image.size.height, height: image.size.width))
        default:
            context.draw(image.cgImage!,
                         in: CGRect(origin: .zero, size: image.size))
    }
    // And now we just create a new UIImage from the drawing context
    guard let cgImage = context.makeImage() else {
        return nil
    }
    return UIImage(cgImage: cgImage)
  }
  
  func cropped(with rect:CGRect) -> UIImage {
    let contextImage: UIImage = UIImage.init(cgImage: self.cgImage!)
    if self.size.width == rect.width && self.size.height == rect.height {
        return self
    }
    let rect = CGRect(x: rect.minX,
                      y: rect.minY,
                      width: rect.width,
                      height: rect.height)
    let imageRef = contextImage.cgImage!.cropping(to: rect)
    let cropped = UIImage(cgImage: imageRef!,
                               scale: self.scale,
                               orientation: self.imageOrientation)
    return cropped
  }
  
  //MARK: Load images by path
  static func images(from pathDirectory:String) -> [UIImage] {
    var images = [UIImage]()
    let path = Bundle.main.resourcePath!
    let imagePath = path + "/\(pathDirectory)"
    let url = URL(fileURLWithPath: imagePath)
    let fileManager = FileManager.default
    let properties = [URLResourceKey.localizedNameKey,
                      URLResourceKey.creationDateKey,
                      URLResourceKey.localizedTypeDescriptionKey]
    do {
      var imageURLs = try fileManager.contentsOfDirectory(at: url,
                                                               includingPropertiesForKeys: properties,
                                                               options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        imageURLs.sort { (url1, url2) -> Bool in
          url2.absoluteString > url1.absoluteString
        }
        for imageURL in imageURLs {
          images.append(UIImage.init(data: try Data.init(contentsOf: imageURL))!)
        }
    } catch let error1 as NSError {
      print(error1.description)
    }
    return images
  }
  
  
  //MARK: Average color
  func averageColor() -> UIColor {
    var bitmap = [UInt8](repeating: 0,
                         count: 4)
    // Get average color.
    let context = CIContext()
    let inputImage: CIImage = ciImage ?? CoreImage.CIImage(cgImage: cgImage!)
    let extent = inputImage.extent
    let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
    let filter = CIFilter(name: "CIAreaAverage",
                          parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
    let outputImage = filter.outputImage!
    let outputExtent = outputImage.extent
    assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
    // Render to bitmap.
    context.render(outputImage,
                   toBitmap: &bitmap,
                   rowBytes: 4,
                   bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                   format: CIFormat.RGBA8,
                   colorSpace: CGColorSpaceCreateDeviceRGB())

    let result = UIColor(red: CGFloat(bitmap[0]) / UIColor.maxRGB,
                         green: CGFloat(bitmap[1]) / UIColor.maxRGB,
                         blue: CGFloat(bitmap[2]) / UIColor.maxRGB,
                         alpha: CGFloat(bitmap[3]) / UIColor.maxRGB)
    return result
  }
}


extension UIImageView {
  func tint(image:UIImage, color:UIColor) {
    tintColor = color
    self.image = image.tinted
  }
}
