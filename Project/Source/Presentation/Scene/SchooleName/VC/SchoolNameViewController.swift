import UIKit
import Then
import SnapKit
import Lottie

class SchoolNameViewController: BaseVC<SchoolNameViewModel> {
    
    private let mainLottieAnimationView = LottieAnimationView(name: "dancing-monkey").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        $0.play()
    }
    
    private let mainTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.text = "DDUBIDUBAB"
    }
    
    private let schoolNameTextField = UITextField().then {
        $0.layer.borderWidth = 1.0
        $0.addLeftPadding()
        $0.placeholder = "학교 이름을 입력해 주세요."
        $0.returnKeyType = .done
    }
    
    private let schoolNameTableView = UITableView().then {
        $0.rowHeight = 100
        $0.register(SchoolNameTableViewCell.self, forCellReuseIdentifier: SchoolNameTableViewCell.cellId)
        $0.backgroundColor = .red
    }
    
    override func configureVC() {
        schoolNameTableView.delegate = self
        schoolNameTableView.dataSource = self
        schoolNameTextField.delegate = self
    }
    
    override func addView() {
        view.addSubViews( mainTitleLabel, mainLottieAnimationView, schoolNameTextField, schoolNameTableView)
    }
    
    override func setLayout() {
        mainLottieAnimationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.height.equalTo(120)
            $0.centerX.equalToSuperview()
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainLottieAnimationView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        schoolNameTextField.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(50)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(35)
        }
        
        schoolNameTableView.snp.makeConstraints {
            $0.top.equalTo(schoolNameTextField.snp.bottom).offset(30)
            $0.width.equalToSuperview()
        }
    }
}


extension SchoolNameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension SchoolNameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = schoolNameTableView.dequeueReusableCell(withIdentifier: SchoolNameTableViewCell.cellId, for: indexPath) as! SchoolNameTableViewCell
        
        cell.textLabel?.text = "dasd"
        
        return cell
    }
}
