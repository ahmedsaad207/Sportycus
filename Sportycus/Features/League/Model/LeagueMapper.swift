import Foundation

func mapFavoriteLeagueToLeague(_ favorite: FavoriteLeague) -> League {
    return League(
        league_key: Int(favorite.leagueKey),
        league_name: favorite.leagueName,
        league_logo: favorite.leagueLogo,
        country_name: favorite.leagueCountry
    )
}

