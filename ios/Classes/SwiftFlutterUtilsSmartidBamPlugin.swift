import Flutter
import UIKit
import SmartId

public class SwiftFlutterUtilsSmartidBamPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_utils_smartid_bam", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterUtilsSmartidBamPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let argsMap: NSDictionary = call.arguments as! NSDictionary

    switch call.method {
        case "getInstance":
            getInstanceSmartId(arguments: argsMap, result: result)
        default:
            result(FlutterMethodNotImplemented)
    }
  }

   private func getInstanceSmartId(arguments: NSDictionary, result: @escaping FlutterResult) {
      SID.shared
        .getRawData()
        .onSuccess(success: { time, response in
          let responseMap: [String: Any] = ["time": time, "response": response]
          result(responseMap)
        })
        .onFailure(failure: { time, message, errorCode in
          let errorMap: [String: Any] = ["time": time, "message": message, "errorCode": errorCode]
          result(FlutterError(code: "\(errorCode)", message: message, details: errorMap))
        })
        .start()
    }
}
