#include <stdio.h>
#include <objc/message.h>

int main(int argc, char *argv[], char *envp[]) {
	// iOS 13
	NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/SettingsCellular.framework"];
	if (![bundle load]) {
		// iOS 12
		bundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/Preferences.framework"];
		if (![bundle load]) {
			printf("Load framework failed.\n");
			return -1;
		}
	}

	Class PSAppDataUsagePolicyCacheClass = NSClassFromString(@"PSAppDataUsagePolicyCache");
	id cacheInstance = [PSAppDataUsagePolicyCacheClass valueForKey:@"sharedInstance"];
	if (!cacheInstance) {
		printf("Instance not found.\n");
		return -1;
	}

	BOOL result = ((BOOL (*)(id, SEL, NSString *, BOOL, BOOL))objc_msgSend)(
		cacheInstance, NSSelectorFromString(@"setUsagePoliciesForBundle:cellular:wifi:"), @"com.saurik.Cydia", true, true);
	if (!result) {
		printf("Fail to enable network for cydia.\n");
	} else {
		printf("Enable network for cydia successfully.\n");
	}

	result = ((BOOL (*)(id, SEL, NSString *, BOOL, BOOL))objc_msgSend)(
		cacheInstance, NSSelectorFromString(@"setUsagePoliciesForBundle:cellular:wifi:"), @"kjc.loader", true, true);
	if (!result) {
		printf("Fail to enable network for checkra1n.\n");
	} else {
		printf("Enable network for checkra1n successfully.\n");
	}

	return 0;
}

