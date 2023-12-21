import Vapor

public struct HXLocalisations {
    public var providers: [String: any HXLocalisable]
    public var defaultLanguageCode: String
    public var overrideLanguagePreference: ((_ req: Request) -> String?)?

    public func localise(text: String, for code: String) -> String {
        guard Locale.isoRegionCodes.contains(code) else { return text }
        if let localisation = providers[code] {
            return localisation.localise(text: text)
        }

        return text
    }

    public init(providers: [String: any HXLocalisable], defaultLanguageCode: String? = nil, overrideLanguagePreference: ((_: Request) -> String?)? = nil) {
        self.providers = providers
        self.overrideLanguagePreference = overrideLanguagePreference
        self.defaultLanguageCode = defaultLanguageCode ?? Locale.current.languageCode ?? "en"
    }
}

public extension HXLocalisations {
    init() {
        providers = [:]
        overrideLanguagePreference = nil
        defaultLanguageCode = Locale.current.languageCode ?? "en"
    }
}
