import UIKit
import RxSwift
import RxCocoa

final class MenuViewController: BaseVC<MenuViewModel>, MenuInfoProtocol {
    var model: SchoolInfo?
    
    var menuData = PublishSubject<[MenuInfo]>()
    
    var menuName: MenuInfo = MenuInfo(dishName: "", mealDay: "", mealName: "")
    
    private let disposeBag = DisposeBag()
    
    private let menuType: [String] = ["조식", "중식", "석식"]
    
    private var dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy년 MM월 dd일"
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 21, weight: .bold)
    }
    
    private let menuContainerView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private let verticalFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 346, height: 402)
    }
    
    private lazy var menuNameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: verticalFlowLayout).then {
        $0.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.cellId)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    init(viewModel: MenuViewModel, model: SchoolInfo) {
        super.init(viewModel: viewModel)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchMenuData() {
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: Date())
        
        guard let atptCode = model?.atptCode else { return }
        guard let schoolCode = model?.schoolCode else { return }
        let mealDate = date
        
        viewModel.fetchMenuInfo(mealDate: "20221207", atptCode: atptCode, schoolCode: schoolCode)
    }

    private func bindCollectionView() {
        menuData.bind(to: menuNameCollectionView.rx.items(cellIdentifier: MenuCollectionViewCell.cellId, cellType: MenuCollectionViewCell.self)) { (row, data, cell) in
            cell.changeCellNameData(with: data)
        }
    }
    
    override func addView() {
        view.addSubViews(titleLabel, menuNameCollectionView)
    }
    
    override func configureVC() {
        let date = dateFormatter.string(from: Date())
        viewModel.delegate = self
        
        bindCollectionView()
        fetchMenuData()
        titleLabel.text = date
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        menuNameCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-150)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }
}
