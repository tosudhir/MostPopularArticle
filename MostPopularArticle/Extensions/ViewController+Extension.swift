//
//  ViewController+Extension.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showAlert(title: String?, message: String?, actions:[String], completion: ((_ tag: Int) -> Void)? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for i in 0..<actions.count {
            let alertAction = UIAlertAction(title: actions[i], style: UIAlertAction.Style.default) { (buttonAction) in
                completion?(i)
            }
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    func hideLodingIndicatore() {
        SVProgressHUD.dismiss()
    }
}
