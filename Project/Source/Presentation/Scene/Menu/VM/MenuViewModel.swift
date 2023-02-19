import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

protocol MenuInfoProtocol: AnyObject {
    var menuData: PublishSubject<[MenuInfo]> { get set }
}

final class MenuViewModel: BaseViewModel {
    weak var delegate: MenuInfoProtocol?
    var menuList: [MenuInfo] = []
    var menu = MenuInfo(dishName: "", mealDay: "", mealName: "")
    
    func fetchMenuInfo(mealDate: String, atptCode: String, schoolCode: String) {
        let provider = MoyaProvider<SchoolAPI>()
        self.menuList = []
        self.menu = MenuInfo(dishName: "", mealDay: "", mealName: "")
        
        provider.request(.menu(mealDate: mealDate, atptCode: atptCode, schoolCode: schoolCode, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                let json = JSON(responseData)
                if json["RESULT"]["CODE"] == "INFO-200" {
                    self.menu.dishName = "밥 없는 날!"
                    self.menuList.append(self.menu)
                }
                else{
                    let data = json["mealServiceDietInfo"].arrayValue
                    let row = data[1]["row"]
                    for index in 0...row.count-1 {
                        self.menu.dishName = row[index]["DDISH_NM"].string ?? "급식 정보가 없습니다."
                        self.menu.mealDay = row[index]["MLSV_YMD"].string ?? "급식 정보가 없습니다."
                        self.menu.mealName = row[index]["MMEAL_SC_NM"].string ?? "급식 정보가 없습니다."
                        self.menuList.append(self.menu)
                    }
                }
                
                self.delegate?.menuData.onNext(self.menuList)
                print(self.menuList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
