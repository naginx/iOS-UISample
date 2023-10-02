import Foundation


/// Dateと他クラス間の変換を担うクラス
final class DateConverter: NSObject {

    static let shared = DateConverter()
    private override init() {}

    private var queue = DispatchQueue(label: "jp.naginx.DateConverter")
    private var cashedFormatters = DateFormatters()

    // 呼び出し元でDateFormatterの内容変更ができてしまうと他のキャッシュ利用箇所に影響が及ぶため、
    // 外部から直接DateFormatterを利用させない
    // 参考: https://williamboles.com/sneaky-date-formatters-exposing-more-than-you-think/
    private func cashedFormatter(config: DateFormatterConfig) -> DateFormatter {
        return queue.sync {
            if let cashed = cashedFormatters.get(config: config) {
                return cashed
            }

            let formatter = DateFormatter()
            formatter.calendar = .default
            formatter.dateFormat = config.format
            formatter.locale = config.locale
            formatter.timeZone = config.timeZone
            cashedFormatters.append(formatter)
            return formatter
        }
    }

    func date(from: String, config: DateFormatterConfig = .default) -> Date? {
        return cashedFormatter(config: config).date(from: from)
    }

    func string(from: Date, config: DateFormatterConfig = .default) -> String {
        return cashedFormatter(config: config).string(from: from)
    }
}

private final class DateFormatters {

    private var list: [DateFormatter] = []

    func get(config: DateFormatterConfig) -> DateFormatter? {
        return list.first(where: { DateFormatterConfig($0) == config })
    }

    func append(_ formatter: DateFormatter) {
        list.append(formatter)
    }
}

struct DateFormatterConfig: Equatable {

    static let `default` = DateFormatterConfig()

    let format: String
    let locale: Locale
    let timeZone: TimeZone

    init(format: String = "yyyyMMdd", locale: Locale = .current, timeZone: TimeZone = .current) {
        self.format = format
        self.locale = locale
        self.timeZone = timeZone
    }

    // 外部でDateFormatterを利用させないため隠蔽
    fileprivate init(_ dateFormatter: DateFormatter) {
        self.format = dateFormatter.dateFormat
        self.locale = dateFormatter.locale
        self.timeZone = dateFormatter.timeZone
    }
}

extension Calendar {

    static var `default`: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = .current
        return calendar
    }
}
