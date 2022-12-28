//
//  Movie.swift
//  Watchify
//
//  Created by User on 09/12/22.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results:[Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
//id = 119051;
//"media_type" = tv;
//name = Wednesday;
//"origin_country" =             (
//    US
//);
//"original_language" = en;
//"original_name" = Wednesday;
//overview = "Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers, stop a monstrous killing spree of the town citizens, and solve the supernatural mystery that affected her family 25 years ago \U2014 all while navigating her new relationships.";
//popularity = "8463.897999999999";
//"poster_path" = "/9PFonBhy4cQy7Jz20NpMygczOkv.jpg";
//"vote_average" = "8.795999999999999";
//"vote_count" = 2284;
