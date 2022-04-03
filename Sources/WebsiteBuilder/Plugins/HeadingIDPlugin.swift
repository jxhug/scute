import SwiftSoup

struct HeadingIDPlugin: Plugin {
    init() {}

    func process(_ article: inout Article) throws {
        let document = try SwiftSoup.parse(article.content)

        let headings = try document.select("h1, h2, h3, h4, h5, h6")

        for heading in headings {
            let text = try heading.text(trimAndNormaliseWhitespace: true)
            let id = text.lowercased().replacingOccurrences(of: " ", with: "-")
            try heading.attr("id", id)
        }

        article.content = try document.outerHtml()
    }
}