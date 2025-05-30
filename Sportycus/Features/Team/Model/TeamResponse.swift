import Foundation

struct TeamResponse : Decodable{
    var result: [Team]
    var success: Int
}
