#import "FlutterUtilsSmartidBamPlugin.h"
#if __has_include(<flutter_utils_smartid_bam/flutter_utils_smartid_bam-Swift.h>)
#import <flutter_utils_smartid_bam/flutter_utils_smartid_bam-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_utils_smartid_bam-Swift.h"
#endif

@implementation FlutterUtilsSmartidBamPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUtilsSmartidBamPlugin registerWithRegistrar:registrar];
}
@end
