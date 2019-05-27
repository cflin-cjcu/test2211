//
//  MyBrowserViewController.swift
//  test1122
//
//  Created by L20102 on 2019/5/6.
//  Copyright © 2019 L20102-02. All rights reserved.
//

import UIKit
import WebKit

class MyBrowserViewController: UIViewController,UITextFieldDelegate, AsyncReponseDelegate{
    func receviedReponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
        print(responseString)
        myWebkit.loadHTMLString(responseString, baseURL: URL(string: "https://www.google.com")!)
    

    }

    @IBOutlet weak var myWebkit: WKWebView!
    @IBOutlet weak var btnGoButtomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //myWebkit.load(URLRequest(url: URL(string: "https://www.google.com")!))
        let worker : AsyncRequestWorker = AsyncRequestWorker()
        worker.reponseDelegate = self
        worker.getResponse(from: "https://www.google.com", tag: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived(notification:)), name: NSNotification.Name(rawValue: "response.received"), object: nil)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "response.received"), object: nil)
    
    }
    
    // MARK: textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let accept = "abcdeABCDE"
        let cs = NSCharacterSet(charactersIn: accept).inverted
        let filters = string.components(separatedBy: cs).joined(separator: "")
        if (string != filters){
            return false }
        
        
        let current = textField.text! as NSString
        //let newString :NSString = current.replacingCharacters(in: range, with: String) as NSString
        //return newString >= 10
        
        
        
        return true
    }
    
    
    @objc func dataReceived(notification: NSNotification?) {
        
        guard let responseString = notification?.userInfo?["aaa"] as? String else {
            return
        }
        print("\(responseString)")
        
        DispatchQueue.main.async {
            self.myWebkit.loadHTMLString(responseString, baseURL: nil)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func keyboardWillAppear(noti:NSNotification?) {
        
        print("keyboardWillAppear")
        guard let frame = noti?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        self.btnGoButtomConstraint.constant = frame.cgRectValue.height
        
    }
    
    @objc func keyboardWillDisappear(noti:NSNotification?)  {
        print("keyboardWillDisappear")
        self.btnGoButtomConstraint.constant = 51;
    }

}
