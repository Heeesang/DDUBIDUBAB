import UIKit
import Lottie
import RxSwift
import RxCocoa

final class SchoolNameViewController: BaseVC<SchoolNameViewModel>, SchoolInfoProtocol {
    private let disposeBag = DisposeBag()
    var model: SchoolInfo?
    
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
    }
    
    private lazy var searchButton = UIButton().then {
        $0.backgroundColor = .black
    }
    
    private func searchButtonDidTap() {
        searchButton.rx.tap
            .bind(onNext: {
                self.fetchSchoolData()
            })
    }
    private func bindTableView() {
        schoolData.bind(to: schoolNameTableView.rx.items(cellIdentifier: SchoolNameTableViewCell.cellId, cellType: SchoolNameTableViewCell.self)) { (row, data, cell) in
        
            cell.changeCellNameData(with: [data])
        }.disposed(by: disposeBag)
        
        schoolNameTableView.rx.modelSelected(SchoolInfo.self)
            .bind(onNext: { [weak self] info in
                self?.viewModel.pushMenuVC(model: info)
            }).disposed(by: disposeBag)
    }
    
    private func fetchSchoolData() {
        viewModel.fetchSchoolName(schoolName: "광주소")
    }
    
    override func configureVC() {
        schoolNameTextField.delegate = self
        viewModel.delegate = self
        
        schoolNameTableView.rowHeight = 90
        schoolNameTableView.showsVerticalScrollIndicator = false
        schoolNameTableView.separatorStyle = .none
        
        fetchSchoolData()
        bindTableView()
        searchButtonDidTap()
    }
    
    override func addView() {
        view.addSubViews( mainTitleLabel, mainLottieAnimationView, schoolNameTextField, schoolNameTableView, searchButton)
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
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
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
