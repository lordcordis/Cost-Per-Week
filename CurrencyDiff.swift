//struct Currency: Identifiable, Codable, Equatable {
//    var id: String { currencyString }
//    
//    let currencyFullTitle: String
//    let currencyString: String
//    let imageSystemName: String
//}
//
//enum CurrencyList: String, CaseIterable {
//    case usDollar = "USD"
//    case euro = "EUR"
//    case russianRuble = "RUR"
//    case georgianLari = "GEL"
//    case japaneseYen = "JPY"
//    case unitedKingdomSterling = "GBP"
//    case turkishLira = "TRY"
//    case indianRupee = "INR"
//    
//    var currency: Currency {
//        switch self {
//        case .usDollar:
//            return Currency(currencyFullTitle: "US Dollar", currencyString: "USD", imageSystemName: "dollarsign")
//        case .euro:
//            return Currency(currencyFullTitle: "Euro", currencyString: "EUR", imageSystemName: "eurosign")
//        case .russianRuble:
//            return Currency(currencyFullTitle: "Russian Ruble", currencyString: "RUR", imageSystemName: "rublesign")
//        case .georgianLari:
//            return Currency(currencyFullTitle: "Georgian Lari", currencyString: "GEL", imageSystemName: "larisign")
//        case .japaneseYen:
//            return Currency(currencyFullTitle: "Japanese Yen", currencyString: "JPY", imageSystemName: "yensign")
//        case .unitedKingdomSterling:
//            return Currency(currencyFullTitle: "United Kingdom Sterling", currencyString: "GBP", imageSystemName: "sterlingsign")
//        case .turkishLira:
//            return Currency(currencyFullTitle: "Turkish Lira", currencyString: "TRY", imageSystemName: "turkishlirasign")
//        case .indianRupee:
//            return Currency(currencyFullTitle: "Indian Rupee", currencyString: "INR", imageSystemName: "indianrupeesign")
//        }
//    }
//}
