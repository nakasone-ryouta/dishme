import Foundation
import UIKit


class Filtering {
    let filters:[CIFilter] = [CIFilter(name: "CISepiaTone")!,
                              CIFilter(name: "CIVignette")!,
                              CIFilter(name: "CIColorPolynomial")!,
                              CIFilter(name: "CIExposureAdjust")!,
                              CIFilter(name: "CIGammaAdjust")!,
                              CIFilter(name: "CIHueAdjust")!,
//                              CIFilter(name: "CIToneCurve")!
                                ]
    
    
    //フィルタを選んで返す
    func getfilter(index: Int,nowimage: UIImage) ->UIImage{
        switch index {
        case 0:
            return cisepiatone(nowimage: nowimage)
        case 1:
            return civignette(nowimage: nowimage)
        case 2:
            return cicolorpolynomial(nowimage: nowimage)
        case 3:
            return ciexposureAdjust(nowimage: nowimage)
        case 4:
            return cigammaAdjust(nowimage: nowimage)
        case 5:
            return cihueAdjust(nowimage: nowimage)
        
            
        default:
            return nowimage
        }
    }
    
    //赤くなるフィルタ
    func cisepiatone(nowimage: UIImage) ->UIImage{
        //フィルタをかける
        let filteredImage = CIImage(image: nowimage)
        self.filters[0].setValue(filteredImage, forKey: "inputImage")
        self.filters[0].setValue(NSNumber(value: 0.5), forKey: "inputIntensity")
        
        let ciContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage((self.filters[0].outputImage)!, from: (self.filters[0].outputImage?.extent)!)
        
        let outputImage = UIImage(cgImage: imageRef!)
        return outputImage
    }
    
    //周りが暗くなるフィルタ
    func civignette(nowimage: UIImage) ->UIImage{
        //フィルタをかける
        let filteredImage = CIImage(image: nowimage)
        self.filters[1].setValue(filteredImage, forKey: "inputImage")
        self.filters[1].setValue(NSNumber(value: 3.0), forKey: "inputIntensity")
        
        let ciContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage((self.filters[1].outputImage)!, from: (self.filters[1].outputImage?.extent)!)
        
        let outputImage = UIImage(cgImage: imageRef!)
        return outputImage
    }
    //ピンクフィルタ
    func cicolorpolynomial(nowimage: UIImage) ->UIImage{
        let ciImage = CIImage(image: nowimage)
        filters[2].setValue(ciImage, forKey: kCIInputImageKey)
        filters[2].setValue(CIVector(x: 0, y: 1, z: 1, w: 1), forKey: "inputRedCoefficients")
        filters[2].setValue(CIVector(x: 0, y: 1, z: 0, w: 1), forKey: "inputGreenCoefficients")
        filters[2].setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputBlueCoefficients")
        filters[2].setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputAlphaCoefficients")
        
        let filteredImage = filters[2].outputImage
        let imageRef = UIImage(ciImage: filteredImage!)
        return imageRef
    }
    //光の調節フィルタ
    func ciexposureAdjust(nowimage: UIImage) ->UIImage{
        let ciImage = CIImage(image: nowimage)
        filters[3].setValue(ciImage, forKey: kCIInputImageKey)
        filters[3].setValue(1.0, forKey: "inputEV")
        
        let filteredImage = filters[3].outputImage
        let imageRef = UIImage(ciImage: filteredImage!)
        return imageRef
    }
    
    //シルエットはっきりフィルタ
    func cigammaAdjust(nowimage: UIImage) ->UIImage{
        
        let ciImage = CIImage(image: nowimage)
        filters[4].setValue(ciImage, forKey: kCIInputImageKey)
        filters[4].setValue(1.3, forKey: "inputPower")
    
        let filteredImage = filters[4].outputImage
        let imageRef = UIImage(ciImage: filteredImage!)
        return imageRef
    }
    
    //色相調節フィルタ
    func cihueAdjust(nowimage: UIImage) ->UIImage{
        
        let ciImage = CIImage(image: nowimage)
        filters[5].setValue(ciImage, forKey: kCIInputImageKey)
        filters[5].setValue(0.7, forKey: "inputAngle")
        
        let filteredImage = filters[5].outputImage
        let imageRef = UIImage(ciImage: filteredImage!)
        return imageRef
    }
    //トーンカーブ
    func citoneCarve(nowimage: UIImage) ->UIImage{
        filters[6].setValue(nowimage, forKey: kCIInputImageKey)
        filters[6].setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        filters[6].setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
        filters[6].setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        filters[6].setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
        filters[6].setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        
        let filteredImage = filters[6].outputImage
        let imageRef = UIImage(ciImage: filteredImage!)
        return imageRef
    }
    //フィルタの個数を返す変数
    func filtercount() -> Int{
        return filters.count
    }
}
