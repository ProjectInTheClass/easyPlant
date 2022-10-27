//
//  LoginViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/10.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FirebaseStorage
import Charts

class LoginViewController: UIViewController ,UITextViewDelegate {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var plantCollectionView: UserPlantCollectionViewController?
    var homeView: HomeViewController?
    
    var userPlantCollectionDelegate : userPlantCollectionDelegate?
    var homeDelegate : HomeDelegate?
    
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            IDField.placeholder = "이미 로그인 된 상태입니다."
            pwField.placeholder = "이미 로그인 된 상태입니다."
        }
        
        updateUI()

    }
    
    
    func updateUI() {
        self.view.bringSubviewToFront(indicatorView)
        
        loginBtn.layer.cornerRadius = 15
        
        IDField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: IDField.frame.size.height-10, width: IDField.layer.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        IDField.layer.addSublayer((border))
        
        pwField.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: pwField.frame.size.height-10, width: pwField.frame.size.width, height: 1)
        border2.backgroundColor = UIColor.lightGray.cgColor
        pwField.layer.addSublayer((border2))
        
        findBtn.layer.cornerRadius = 15
        joinBtn.layer.cornerRadius = 15
        setupProviderLoginView()
        
        loginBtn.layer.cornerRadius = 10
        
        indicatorView.hidesWhenStopped = true
        indicatorView.stopAnimating()
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
        self.stackView.addArrangedSubview(authorizationButton)
      }
    
    
    @available(iOS 13, *)
    @objc func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
        
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        if IDField.text! == "" {
            showAlert(message: "아이디를 입력해주세요")
            return
        }
        
        if pwField.text == "" {
            showAlert(message: "비밀번호를 입력해주세요")
            return
        }
        self.indicatorView.startAnimating()
        
        Auth.auth().signIn(withEmail: IDField.text!, password: pwField.text!) {
            (user, error) in
            if user != nil {
                if ((Auth.auth().currentUser?.isEmailVerified == true)) {
                    deleteLocalData()
                    
                    self.loadUserInfoAndUpdateValue()
                    self.loadUserPlantAndDismiss()
                } else {
                    self.indicatorView.stopAnimating()
                    self.showAlert(message: "이메일 인증을 완료해주세요")
                    do {
                        try Auth.auth().signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    return
                }
                
            } else {
                self.showAlert(message: "아이디와 비밀번호를 다시 입력해주세요")
                print("로그인 실패")
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "잘못된 로그인입니다.", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print("error")
                    print(error?.localizedDescription ?? "")
                    return
                }
                guard (authResult?.user) != nil else { return }
                
                self.indicatorView.startAnimating()
                
                deleteLocalData()
                
                if Auth.auth().currentUser?.displayName == nil {
                    myUser = User(Date())
                    userPlants = []
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = appleIDCredential.fullName?.givenName ?? Auth.auth().currentUser?.displayName
                    changeRequest?.commitChanges(completion: { (error) in
                        if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print("Updated display name: \(Auth.auth().currentUser?.displayName)")
                            }
                        })
                    
                    myUser.updateUser()
                    saveUserInfo(user: myUser)
                    saveNewUserPlant(plantsList: userPlants, archiveURL: archiveURL)
                }
                
                self.loadUserInfoAndUpdateValue()
                self.loadUserPlantAndDismiss()
                
                
                
            }   
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
    
    //userPlant 정보 가져오기
    func loadUserPlantAndDismiss(){
        let jsonDecoder = JSONDecoder()
        
        //로컬에 없다면 원격 저장소에서 받아온다
        if let data = NSData(contentsOf: archiveURL){
            //로컬에 정보가 존재할 경우 로컬 저장소에서 사용
            do {
                let decoded = try jsonDecoder.decode([UserPlant].self, from: data as Data)
                userPlants = decoded
            } catch {
                print(error)
            }
        }
        else {
            // Create a reference to the file you want to download
            var filePath = ""
            if let user = Auth.auth().currentUser {
                filePath = "/\(user.uid)/userPlantList/plants"
            } else {
                filePath = "/sampleUser/userPlantList/plants"
            }
            let infoRef = storageRef.child(filePath)

            // Download to the local filesystem
        
            infoRef.write(toFile: archiveURL) { url, error in
              if let error = error {
                print("download to local userPlants error : \(error)")

              } else {
                let data = NSData(contentsOf: url!)
                do {
                    let decoded = try jsonDecoder.decode([UserPlant].self, from: data! as Data)
                    userPlants = decoded
                    
                    
                    // modal이라서 update가 안되기 때문에 delegate로 update
                    self.homeDelegate?.reloadTableViewAndCalendar()
                    self.userPlantCollectionDelegate?.reloadCollectionView()
                    
                    self.indicatorView.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                } catch {
                    print(error)
                }
              }
            }
        }
    }
    
    //user 정보 가져오기
    func loadUserInfoAndUpdateValue() {
        let jsonDecoder = JSONDecoder()
        
        //로컬에 없다면 원격 저장소에서 받아온다
        if let data = NSData(contentsOf: userInfoURL){
            //로컬에 정보가 존재할 경우 로컬 저장소에서 사용
            do {
                let decoded = try jsonDecoder.decode(User.self, from: data as Data)
                myUser = decoded
            } catch {
                print(error)
            }
        }
        else {
            // Create a reference to the file you want to download
            var filePath = ""
            if let user = Auth.auth().currentUser {
                filePath = "/\(user.uid)/userInfo/info"
            } else {
                filePath = "/sampleUser/userInfo/info"
            }
            
            let infoRef = storageRef.child(filePath)
            
            // Download to the local filesystem
            infoRef.write(toFile: userInfoURL) { url, error in
              if let error = error {
                print("download to local user info error : \(error)")

              } else {
                let data = NSData(contentsOf: url!)
                do {
                    let decoded = try jsonDecoder.decode(User.self, from: data! as Data)
                    myUser = decoded
                    
                    // modal이라서 update가 안되기 때문에 delegate로 update
                    self.homeDelegate?.reloadHome()
                    
                } catch {
                    print(error)
                }
              }
            }
       }
    }
}


extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
