import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    
    override func start() {
        let vm = SchoolNameViewModel(coordinator: self)
        let vc = SchoolNameViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: BabStep) {
        switch step {
        case .menuRequired(let model):
            menuIsRequired(model: model)
        default:
            return
        }
    }
}

extension AppCoordinator {
    private func menuIsRequired(model: SchoolInfo) {
        let vc = MenuCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinatrs.append(vc)
        vc.startMenuVC(model: model)
    }
}
