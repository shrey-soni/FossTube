//
//  StringExtension.swift
//  FossTube
//
//  Created by Shrey Soni on 09/09/22.
//

import Foundation
import UIKit

extension String{
    func loadThisAsImage()->UIImage{
        do{
            guard let url=URL(string: self) else{
                return UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
            }
            let data:Data=try Data(contentsOf:url)
            return UIImage(data: data)!
        }catch{
            debugPrint("Error in Loading image from URL: " + URL(string: self)!.absoluteString)
        }
        return UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
    }
}
