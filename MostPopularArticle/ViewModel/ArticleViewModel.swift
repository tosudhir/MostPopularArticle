//
//  ArticleViewModel.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import Foundation

struct ArticleViewModel {

    let title: String
    let byline: String
    let publishedDate: String
    let abstract: String
    let thumbnailUrlString: String?
    let imageUrlString: String?
    
    init(article: Article) {
        self.title = article.title
        self.byline = article.byline
        self.publishedDate = article.publishedDate
        self.abstract = article.abstract
        let mediaMetaData = article.media.first?.mediaMetadata
        self.thumbnailUrlString = mediaMetaData?.filter{
            $0.format == "Thumbnail"
            }.first?.url
        self.imageUrlString = mediaMetaData?.filter{
            $0.format == "Medium"
            }.first?.url
    }
}
