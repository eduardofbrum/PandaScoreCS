import Foundation

func formatMatchDate(dateString: String, fromFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = fromFormat
    
    guard let date = dateFormatter.date(from: dateString) else {
        return "TBD"
    }
    
    dateFormatter.locale = Locale.current
    
    if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "'Hoje,' HH:mm"
    } else if Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
        dateFormatter.dateFormat = "E, HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate.replacingOccurrences(of: ".", with: "").capitalized
    } else {
        dateFormatter.dateFormat = "dd.MM HH:mm"
    }
    
    return dateFormatter.string(from: date)
}
