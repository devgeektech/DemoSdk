//
//  Constants.swift
//  SdkDemo
//
//  Created by Geek Tech on 15/05/24.
//

import Foundation
private let QW_TAG  = "Constants"

func getInItScript(appId: String) -> String {
    return """
        var app_id = "\(appId)";
        window.qwSettings = {
          appId: app_id,
        };
        !(function () {
          if (!window.qwTracking) {
            (window.qwTracking = Object.assign({}, window.qwTracking, {
              queue:
                window.qwTracking && window.qwTracking.queue
                  ? window.qwTracking.queue
                  : [],
              track: function (t) {
                console.log("track");
                this.queue.push({ type: "track", props: t });
              },
              init: function (t) {
                console.log("init");
                this.queue.push({ type: "init", props: t });
              },
            })),
              window.qwSettings;
            var t = function (t) {
              console.log("create",window?.qwSettings?.appId);
              var e = document.createElement("script");
              (e.type = "text/javascript"),
                (e.async = !0),
                (e.src =
                  "/Users/geektech/Desktop/QwaryiOS/qw.intercept.sdk.merged.js?id=" +
                  app_id);
              var n = document.getElementsByTagName("script")[0];
              // Satinder Change as n is undefined  n.parentNode.insertBefore(e,n)
                document.head.appendChild(e);
            };
            "complete" === document.readyState
              ? t()
              : window.attachEvent
                ? window.attachEvent("onload", t)
                : window.addEventListener("load", t, !1);
          }
        })(),
          qwTracking.init(qwSettings);
    """
}

public func getInItScript(appId: String, visitorId: String) -> String {
    return """
        var app_id = "\(appId)";
        window.qwSettings = {
            appId: app_id,
            identifier: 'email',
            contact: { //you can also populate custom attributes in this
                firstName: '%CONTACT_FIRST_NAME%',
                lastName: '%CONTACT_LAST_NAME%',
                email: '%CONTACT_EMAIL_NAME%'
            }
        };
        !function() {
            if (!window.qwTracking) {
                window.qwTracking = Object.assign({}, window.qwTracking, {
                    queue: window.qwTracking && window.qwTracking.queue ? window.qwTracking.queue : [],
                    track: function (t) {
                        this.queue.push({
                            type: "track",
                            props: t
                        })
                    },
                    init: function (t) {
                        this.queue.push({
                            type: "init",
                            props: t
                        })
                    }
                }), window.qwSettings;
                var t = function (t) {
                    var e = document.createElement("script");
                    // Satinder Change the e.src
                    e.type = "text/javascript", e.async = !0, e.src = "file:///android_asset/qw.intercept.sdk.merged.js?id=" + app_id;
                    var n = document.getElementsByTagName("script")[0];
                    // Satinder Change as n is undefined  n.parentNode.insertBefore(e,n)
                    document.head.appendChild(e);
                };
                "complete" === document.readyState ? t() : window.attachEvent ? window.attachEvent("onload", t) : window.addEventListener("load", t, !1)
            }
        }(), qwTracking.init(qwSettings);
    """
}

func getEventTrackScript(eventName: String) -> String {
    return "qwTracking.track('\(eventName)');"
}

func getLogoutScript() -> String {
    return "qwTracking.logout();"
}

func objectFromString<Model: Codable>(json: String, classOfModel: Model.Type) -> Model? {
    let decoder = JSONDecoder()
    do {
        let model = try decoder.decode(Model.self, from: Data(json.utf8))
        return model
    } catch {
        print("\(QW_TAG): Error decoding JSON - \(error)")
        return nil
    }
}

func jsonFromModel<Model: Codable>(model: Model) -> String? {
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(model)
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    } catch {
        print("\(QW_TAG): Error encoding model to JSON - \(error)")
        return nil
    }
}
struct QWSettings: Codable {
    let appId: String
    let osPlatform: String
    let firstName: String?
    let lastName: String?
    let email: String?
}
extension QWSettings {
    func toJsonStringify() -> String? {
        return jsonFromModel(model: self)
    }
}

