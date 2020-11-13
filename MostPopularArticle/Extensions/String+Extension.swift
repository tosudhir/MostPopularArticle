//
//  String+Extension.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import UIKit

extension String {
    
    enum PlaceImage {
        case before
        case after
    }
    
    func addImageToString(imageName: String, place: PlaceImage = .before) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: self)
        let blankSpace = NSMutableAttributedString(string: " ")
        // create our NSTextAttachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        let imageOffsetY: CGFloat = -1
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 10, height: 10)
        let imageString = NSMutableAttributedString(attachment: imageAttachment)
        switch(place) {
        case .after:
            fullString.append(blankSpace)
            fullString.append(imageString)
            return fullString
        case .before:
            imageString.append(blankSpace)
            imageString.append(fullString)
            return imageString
        }
    }
}
