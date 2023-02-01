import UIKit
import Lottie
import RxSwift
import RxCocoa

class SchoolNameViewController: BaseVC<SchoolNameViewModel>, SchoolInfoProtocol {
    private let disposeBag = DisposeBag()
    
    var schoolData = PublishSubject<[SchoolInfo]>()
    
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
        $0.register(SchoolNameTableViewCell.self, forCellReuseIdentifier: SchoolNameTableViewCell.cellId)
        $0.backgroundColor = .blue
    }
    
    private func bindTableView() {
        schoolData.bind(to: schoolNameTableView.rx.items(cellIdentifier: SchoolNameTableViewCell.cellId, cellType: SchoolNameTableViewCell.self)) { (row, data, cell) in
            
            cell.changeCellData(with: data.row ?? .init())
        }.disposed(by: disposeBag)
    }
    
    private func fetchSchoolData() {
        viewModel.fetchSchoolName(schoolName: "비아")
    }
    
    override func configureVC() {
        schoolNameTextField.delegate = self
        
        fetchSchoolData()
        bindTableView()
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
            $0.leading.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview()
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
