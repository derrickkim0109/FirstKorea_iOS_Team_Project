//
//  LoginViewController.swift
//  loginView
//
//  Created by TJ on 2021/02/25.
//

import UIKit

class LoginViewController: UIViewController, DbLoginCheckProtocol{
    
    

    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var btnTabAutoLogin: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnFindId: UIButton!
    @IBOutlet weak var btnFindPw: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnKakaoLogin: UIButton!
    @IBOutlet weak var btnNaverLogin: UIButton!
    
    
    let rightButton  = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard !UserDefaults.standard.bool(forKey: "autoLogin") else {
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            return
        }
        
        rightButton.setImage(UIImage(systemName: "eye"), for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        tfPw.rightViewMode = .always
        tfPw.rightView = rightButton
        
        
        tfPw.isSecureTextEntry.toggle()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnTabAutoLogin(_ sender: UIButton) {
        sender.isSelected.toggle()
        print(sender.isSelected)
        // true ??? ??? : ????????? ????????????
        // false??? ??? : ???????????? ????????????
    }
    
    
    // ????????? ??????
    @IBAction func btnLogin(_ sender: UIButton) {
        let inputId = tfId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isValidEmail(testStr: inputId){
            let dbLoginCheck = DBLoginCheck()
            dbLoginCheck.delegate = self
            dbLoginCheck.check(id: inputId, pw: inputPw)
        }else{
            let emailAlert = UIAlertController(title: "??????", message: "????????? ????????? ????????????.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            emailAlert.addAction(okAction)
            present(emailAlert, animated: true, completion: nil)
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }
    
    
    func loginResult(result: Int) {
        print(result)
        switch result {
        case 1:
            print("????????? ??????")
            if btnTabAutoLogin.isSelected {
                UserDefaults.standard.set(true, forKey: "autoLogin")
            }
            // ???????????? ??????
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            break
        case 0:
            print("???????????? ??????")
            let resultAlert = UIAlertController(title: "??????", message: "??????????????? ?????? ??????????????????", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.tfPw.becomeFirstResponder()
                
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
            break
        case -1:
            print("????????? ??????")
            let resultAlert = UIAlertController(title: "??????", message: "???????????? ?????? ??????????????????", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.tfId.becomeFirstResponder()
                
            })
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    
    // ????????? ??????
    @IBAction func btnFindId(_ sender: UIButton) {
    }
    
    // ???????????? ??????
    @IBAction func btnFindPw(_ sender: UIButton) {
    }
    
    // ????????????
    @IBAction func btnSignIn(_ sender: UIButton) {
    }
    
    
    // ????????? ?????????
    @IBAction func btnKakaoLogin(_ sender: UIButton) {
    }
    
    // ????????? ?????????
    @IBAction func btnNaverLogin(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
} // ----
