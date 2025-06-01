import Foundation

protocol FavoritePresenterProtocol {
    func getLeagues()
    func deleteLeague(key: Int)
}

class FavoritePresenter : FavoritePresenterProtocol{
    var vc: FavoriteViewProtocol!
    let local = FavoriteLocalDataSource()
    
    init(vc: FavoriteViewProtocol!) {
        self.vc = vc
    }

    func getLeagues() {
        let data = local.getLeagues()
        vc.renderToView(data: data)
    }

    func deleteLeague(key: Int) {
        local.deleteLeague(key: key)
    }
    
    
    
}
