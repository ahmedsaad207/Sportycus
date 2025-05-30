import Foundation

struct Team : Decodable{
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]
}
