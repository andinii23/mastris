// To parse this JSON data, do
//
//     final detailBeritaM = detailBeritaMFromJson(jsonString);

import 'dart:convert';

DetailBeritaM detailBeritaMFromJson(String str) => DetailBeritaM.fromJson(json.decode(str));

String detailBeritaMToJson(DetailBeritaM data) => json.encode(data.toJson());

class DetailBeritaM {
    int id;
    DateTime date;
    DateTime dateGmt;
    Guid guid;
    DateTime modified;
    DateTime modifiedGmt;
    String slug;
    String status;
    String type;
    String link;
    Guid title;
    Content content;
    Content excerpt;
    int author;
    int featuredMedia;
    String commentStatus;
    String pingStatus;
    bool sticky;
    String template;
    String format;
    List<dynamic> meta;
    List<int> categories;
    List<dynamic> tags;
    String yoastHead;
    YoastHeadJson yoastHeadJson;
    Links links;

    DetailBeritaM({
        required this.id,
        required this.date,
        required this.dateGmt,
        required this.guid,
        required this.modified,
        required this.modifiedGmt,
        required this.slug,
        required this.status,
        required this.type,
        required this.link,
        required this.title,
        required this.content,
        required this.excerpt,
        required this.author,
        required this.featuredMedia,
        required this.commentStatus,
        required this.pingStatus,
        required this.sticky,
        required this.template,
        required this.format,
        required this.meta,
        required this.categories,
        required this.tags,
        required this.yoastHead,
        required this.yoastHeadJson,
        required this.links,
    });

    factory DetailBeritaM.fromJson(Map<String, dynamic> json) => DetailBeritaM(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        guid: Guid.fromJson(json["guid"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        type: json["type"],
        link: json["link"],
        title: Guid.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        excerpt: Content.fromJson(json["excerpt"]),
        author: json["author"],
        featuredMedia: json["featured_media"],
        commentStatus: json["comment_status"],
        pingStatus: json["ping_status"],
        sticky: json["sticky"],
        template: json["template"],
        format: json["format"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        categories: List<int>.from(json["categories"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        yoastHead: json["yoast_head"],
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "date_gmt": dateGmt.toIso8601String(),
        "guid": guid.toJson(),
        "modified": modified.toIso8601String(),
        "modified_gmt": modifiedGmt.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title.toJson(),
        "content": content.toJson(),
        "excerpt": excerpt.toJson(),
        "author": author,
        "featured_media": featuredMedia,
        "comment_status": commentStatus,
        "ping_status": pingStatus,
        "sticky": sticky,
        "template": template,
        "format": format,
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "yoast_head": yoastHead,
        "yoast_head_json": yoastHeadJson.toJson(),
        "_links": links.toJson(),
    };
}

class Content {
    String rendered;
    bool protected;

    Content({
        required this.rendered,
        required this.protected,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };
}

class Guid {
    String rendered;

    Guid({
        required this.rendered,
    });

    factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}

class Links {
    List<About> self;
    List<About> collection;
    List<About> about;
    List<AuthorElement> author;
    List<AuthorElement> replies;
    List<VersionHistory> versionHistory;
    List<PredecessorVersion> predecessorVersion;
    List<AuthorElement> wpFeaturedmedia;
    List<About> wpAttachment;
    List<WpTerm> wpTerm;
    List<Cury> curies;

    Links({
        required this.self,
        required this.collection,
        required this.about,
        required this.author,
        required this.replies,
        required this.versionHistory,
        required this.predecessorVersion,
        required this.wpFeaturedmedia,
        required this.wpAttachment,
        required this.wpTerm,
        required this.curies,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author: List<AuthorElement>.from(json["author"].map((x) => AuthorElement.fromJson(x))),
        replies: List<AuthorElement>.from(json["replies"].map((x) => AuthorElement.fromJson(x))),
        versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
        wpFeaturedmedia: List<AuthorElement>.from(json["wp:featuredmedia"].map((x) => AuthorElement.fromJson(x))),
        wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
        wpTerm: List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "version-history": List<dynamic>.from(versionHistory.map((x) => x.toJson())),
        "predecessor-version": List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
        "wp:attachment": List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
    };
}

class About {
    String href;

    About({
        required this.href,
    });

    factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class AuthorElement {
    bool embeddable;
    String href;

    AuthorElement({
        required this.embeddable,
        required this.href,
    });

    factory AuthorElement.fromJson(Map<String, dynamic> json) => AuthorElement(
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
    };
}

class Cury {
    String name;
    String href;
    bool templated;

    Cury({
        required this.name,
        required this.href,
        required this.templated,
    });

    factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
    };
}

class PredecessorVersion {
    int id;
    String href;

    PredecessorVersion({
        required this.id,
        required this.href,
    });

    factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
        id: json["id"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "href": href,
    };
}

class VersionHistory {
    int count;
    String href;

    VersionHistory({
        required this.count,
        required this.href,
    });

    factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
        count: json["count"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "href": href,
    };
}

class WpTerm {
    String taxonomy;
    bool embeddable;
    String href;

    WpTerm({
        required this.taxonomy,
        required this.embeddable,
        required this.href,
    });

    factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        taxonomy: json["taxonomy"],
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "taxonomy": taxonomy,
        "embeddable": embeddable,
        "href": href,
    };
}

class YoastHeadJson {
    String title;
    dynamic description;
    Robots robots;
    String canonical;
    String ogLocale;
    String ogType;
    String ogTitle;
    String ogDescription;
    String ogUrl;
    String ogSiteName;
    DateTime articlePublishedTime;
    List<OgImage> ogImage;
    String twitterCard;
    TwitterMisc twitterMisc;
    Schema schema;

    YoastHeadJson({
        required this.title,
        this.description,
        required this.robots,
        required this.canonical,
        required this.ogLocale,
        required this.ogType,
        required this.ogTitle,
        required this.ogDescription,
        required this.ogUrl,
        required this.ogSiteName,
        required this.articlePublishedTime,
        required this.ogImage,
        required this.twitterCard,
        required this.twitterMisc,
        required this.schema,
    });

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        title: json["title"],
        description: json["description"],
        robots: Robots.fromJson(json["robots"]),
        canonical: json["canonical"],
        ogLocale: json["og_locale"],
        ogType: json["og_type"],
        ogTitle: json["og_title"],
        ogDescription: json["og_description"],
        ogUrl: json["og_url"],
        ogSiteName: json["og_site_name"],
        articlePublishedTime: DateTime.parse(json["article_published_time"]),
        ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
        twitterCard: json["twitter_card"],
        twitterMisc: TwitterMisc.fromJson(json["twitter_misc"]),
        schema: Schema.fromJson(json["schema"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "robots": robots.toJson(),
        "canonical": canonical,
        "og_locale": ogLocale,
        "og_type": ogType,
        "og_title": ogTitle,
        "og_description": ogDescription,
        "og_url": ogUrl,
        "og_site_name": ogSiteName,
        "article_published_time": articlePublishedTime.toIso8601String(),
        "og_image": List<dynamic>.from(ogImage.map((x) => x.toJson())),
        "twitter_card": twitterCard,
        "twitter_misc": twitterMisc.toJson(),
        "schema": schema.toJson(),
    };
}

class OgImage {
    int width;
    int height;
    String url;
    String type;

    OgImage({
        required this.width,
        required this.height,
        required this.url,
        required this.type,
    });

    factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "type": type,
    };
}

class Robots {
    String index;
    String follow;
    String maxSnippet;
    String maxImagePreview;
    String maxVideoPreview;

    Robots({
        required this.index,
        required this.follow,
        required this.maxSnippet,
        required this.maxImagePreview,
        required this.maxVideoPreview,
    });

    factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: json["index"],
        follow: json["follow"],
        maxSnippet: json["max-snippet"],
        maxImagePreview: json["max-image-preview"],
        maxVideoPreview: json["max-video-preview"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "follow": follow,
        "max-snippet": maxSnippet,
        "max-image-preview": maxImagePreview,
        "max-video-preview": maxVideoPreview,
    };
}

class Schema {
    String context;
    List<Graph> graph;

    Schema({
        required this.context,
        required this.graph,
    });

    factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        context: json["@context"],
        graph: List<Graph>.from(json["@graph"].map((x) => Graph.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "@context": context,
        "@graph": List<dynamic>.from(graph.map((x) => x.toJson())),
    };
}

class Graph {
    String type;
    String id;
    String? url;
    String? name;
    String? description;
    List<PotentialAction>? potentialAction;
    String? inLanguage;
    String? contentUrl;
    int? width;
    int? height;
    BreadcrumbClass? isPartOf;
    BreadcrumbClass? primaryImageOfPage;
    DateTime? datePublished;
    DateTime? dateModified;
    BreadcrumbClass? author;
    BreadcrumbClass? breadcrumb;
    List<ItemListElement>? itemListElement;
    Image? image;
    List<String>? sameAs;

    Graph({
        required this.type,
        required this.id,
        this.url,
        this.name,
        this.description,
        this.potentialAction,
        this.inLanguage,
        this.contentUrl,
        this.width,
        this.height,
        this.isPartOf,
        this.primaryImageOfPage,
        this.datePublished,
        this.dateModified,
        this.author,
        this.breadcrumb,
        this.itemListElement,
        this.image,
        this.sameAs,
    });

    factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        type: json["@type"],
        id: json["@id"],
        url: json["url"],
        name: json["name"],
        description: json["description"],
        potentialAction: json["potentialAction"] == null ? [] : List<PotentialAction>.from(json["potentialAction"]!.map((x) => PotentialAction.fromJson(x))),
        inLanguage: json["inLanguage"],
        contentUrl: json["contentUrl"],
        width: json["width"],
        height: json["height"],
        isPartOf: json["isPartOf"] == null ? null : BreadcrumbClass.fromJson(json["isPartOf"]),
        primaryImageOfPage: json["primaryImageOfPage"] == null ? null : BreadcrumbClass.fromJson(json["primaryImageOfPage"]),
        datePublished: json["datePublished"] == null ? null : DateTime.parse(json["datePublished"]),
        dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
        author: json["author"] == null ? null : BreadcrumbClass.fromJson(json["author"]),
        breadcrumb: json["breadcrumb"] == null ? null : BreadcrumbClass.fromJson(json["breadcrumb"]),
        itemListElement: json["itemListElement"] == null ? [] : List<ItemListElement>.from(json["itemListElement"]!.map((x) => ItemListElement.fromJson(x))),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        sameAs: json["sameAs"] == null ? [] : List<String>.from(json["sameAs"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "url": url,
        "name": name,
        "description": description,
        "potentialAction": potentialAction == null ? [] : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
        "inLanguage": inLanguage,
        "contentUrl": contentUrl,
        "width": width,
        "height": height,
        "isPartOf": isPartOf?.toJson(),
        "primaryImageOfPage": primaryImageOfPage?.toJson(),
        "datePublished": datePublished?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "author": author?.toJson(),
        "breadcrumb": breadcrumb?.toJson(),
        "itemListElement": itemListElement == null ? [] : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
        "image": image?.toJson(),
        "sameAs": sameAs == null ? [] : List<dynamic>.from(sameAs!.map((x) => x)),
    };
}

class BreadcrumbClass {
    String id;

    BreadcrumbClass({
        required this.id,
    });

    factory BreadcrumbClass.fromJson(Map<String, dynamic> json) => BreadcrumbClass(
        id: json["@id"],
    );

    Map<String, dynamic> toJson() => {
        "@id": id,
    };
}

class Image {
    String type;
    String id;
    String inLanguage;
    String url;
    String contentUrl;
    String caption;

    Image({
        required this.type,
        required this.id,
        required this.inLanguage,
        required this.url,
        required this.contentUrl,
        required this.caption,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        type: json["@type"],
        id: json["@id"],
        inLanguage: json["inLanguage"],
        url: json["url"],
        contentUrl: json["contentUrl"],
        caption: json["caption"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "inLanguage": inLanguage,
        "url": url,
        "contentUrl": contentUrl,
        "caption": caption,
    };
}

class ItemListElement {
    String type;
    int position;
    String name;
    String? item;

    ItemListElement({
        required this.type,
        required this.position,
        required this.name,
        this.item,
    });

    factory ItemListElement.fromJson(Map<String, dynamic> json) => ItemListElement(
        type: json["@type"],
        position: json["position"],
        name: json["name"],
        item: json["item"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "position": position,
        "name": name,
        "item": item,
    };
}

class PotentialAction {
    String type;
    dynamic target;
    String? queryInput;

    PotentialAction({
        required this.type,
        required this.target,
        this.queryInput,
    });

    factory PotentialAction.fromJson(Map<String, dynamic> json) => PotentialAction(
        type: json["@type"],
        target: json["target"],
        queryInput: json["query-input"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "target": target,
        "query-input": queryInput,
    };
}

class TargetClass {
    String type;
    String urlTemplate;

    TargetClass({
        required this.type,
        required this.urlTemplate,
    });

    factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
        type: json["@type"],
        urlTemplate: json["urlTemplate"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "urlTemplate": urlTemplate,
    };
}

class TwitterMisc {
    String writtenBy;
    String estReadingTime;

    TwitterMisc({
        required this.writtenBy,
        required this.estReadingTime,
    });

    factory TwitterMisc.fromJson(Map<String, dynamic> json) => TwitterMisc(
        writtenBy: json["Written by"],
        estReadingTime: json["Est. reading time"],
    );

    Map<String, dynamic> toJson() => {
        "Written by": writtenBy,
        "Est. reading time": estReadingTime,
    };
}
