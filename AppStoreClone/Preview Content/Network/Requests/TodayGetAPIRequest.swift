//
//
// TodayGetAPIRequest.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//
        
import Foundation

struct TodayGetAPIRequest: APIRequestable {
    var path: String = ""
    var method: String = ""
    var headers: [String : Any]?
    var body: Data? = nil
    var baseURL: URL? = nil
    var shouldRetry: Bool = false
    var shouldStubResponse: Bool = true
    
    var stubbedResponseData: Data? {
        """
[
  {
    "cardType": "sponsored",
    "cardHeader": {
      "subheadline": "New Update",
      "headline": "World of Apps",
      "spotline": "Daily picks of the best apps"
    },
    "image": "https://thesologlobetrotter.com/wp-content/uploads/2020/08/machu-picchu-1569324_1280-768x508.jpg",
    "appCardImageOverlayModel": {
      "subheadline": "Sponsored",
      "headline": "Boost Your Productivity",
      "spotline": "Limited-time offer"
    },
    "appInfoModel": {
      "installStatus": "notInstalled",
      "image": "https://cdn.dribbble.com/userupload/16140467/file/original-1978a512ad336c5a65d26100255e1363.jpg?resize=752x&vertical=center",
      "appName": "Productivity Pro",
      "productLine": "Utilities",
      "userEmail": "abc.abc.abc",
      "publisher": "NK V"
    }
  },
  {
    "cardType": "plain",
    "cardHeader": {
      "headline": "Discover Something New"
    },
    "image": "https://cdn.dribbble.com/userupload/15978221/file/original-ed1d0627b66acbe20a5b0551d54e910a.jpeg?resize=752x&vertical=center",
    "appCardImageOverlayModel": {
      "subheadline": "Get Started",
      "headline": "Are you a Solo Flyer?"
    }
  },
  {
    "cardType": "groupedApps",
    "cardHeader": {
      "headline": "Express Yourself"
    },
    "image": "https://cdn.dribbble.com/userupload/17564767/file/original-bb485e6597712fb4cbde91bae9fc3644.png?resize=752x&vertical=center",
    "appCardImageOverlayModel": {
      "subheadline": "ESSENTIALS",
      "headline": "Get creative with your photos and videos"
    }
  },
  {
    "cardType": "plain",
    "image": "https://cdn.dribbble.com/userupload/14785220/file/original-25540efc8ec9d03ff33fbd7f9754bc1a.png?resize=512x512&vertical=center",
    "appCardImageOverlayModel": {
      "headline": "Throwing a Game Party?",
      "spotline": "Grab some friends and play"
    },
    "appInfoModel": {
      "installStatus": "notInstalled",
      "image": "https://cdn.dribbble.com/userupload/10867807/file/original-0ab84e6336e44d251490a9f534d1103b.png?resize=752x&vertical=center",
      "appName": "Fun Game",
      "productLine": "Games",
      "userEmail": "abc.abc.abc",
      "publisher": "NK V"
    }
  },
  {
    "cardType": "sponsored",
    "image": "https://cdn.dribbble.com/userupload/16963758/file/original-c80265d5d3b7ef374496382e34a6d46b.jpg?resize=752x&vertical=center",
    "appCardImageOverlayModel": {
      "subheadline": "Sponsored",
      "headline": "Discover New Music",
      "spotline": "Exclusive playlists"
    }
  },
  {
    "cardType": "groupedApps",
    "cardHeader": {
      "headline": "Explore New Hobbies",
      "spotline": "Embraace your latest passion with these handy helpers"
    },
    "image": "https://cdn.dribbble.com/userupload/9630995/file/original-f662910d328647420dffacf5aa67f38e.jpg?resize=752x&vertical=center",
    "appCardImageOverlayModel": {
      "headline": "Wattpad",
      "spotline": "Publish your novel or story in a few steps"
    }
  },
  {
    "cardType": "plain",
    "cardHeader": {
      "subheadline": "LEARNING",
      "headline": "Expand Your Knowledge",
      "spotline": "Educational apps for all ages"
    },
    "image": "https://i.pinimg.com/736x/e0/37/ee/e037eec0ca00dc0773058578f5d8d94b.jpg",
    "appCardImageOverlayModel": {
      "subheadline": "Life HACK",
      "headline": "Vital apps to improve your health"
    },
    "appInfoModel": {
      "installStatus": "notInstalled",
      "image": "https://cdn.dribbble.com/userupload/17660972/file/original-1e928cb0e5e2717a7099f49e36a17a1e.png?resize=752x&vertical=center",
      "appName": "Learn Something New",
      "productLine": "Education",
      "userEmail": "abc.abc.abc",
      "publisher": "NK V"
    }
  }
]
""".data(using: .utf8)
    }
}
