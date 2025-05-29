import Foundation

struct LeagueResponse : Decodable{
    var result: [League]
    var success: Int
}
