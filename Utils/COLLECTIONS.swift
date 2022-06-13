//
//  COLLECTIONS.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import Foundation
import Firebase

// MARK: - https://icksw.tistory.com/120

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_COMMUNITYS = Firestore.firestore().collection("communitys")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_JOINERS = Firestore.firestore().collection("joiners")
let COLLECTION_JOINING = Firestore.firestore().collection("joining")
//let COLLECTION_NEWSPOSTS = Firestore.firestore().collection("news-posts")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
let COLLECTION_NEWS = Firestore.firestore().collection("News")
