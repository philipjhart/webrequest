#import "AppDelegate.h"
#import "ListController.h"
#import "SMWebRequest.h"

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(UIApplication *)application {
	
	SMWebRequest *request = [SMWebRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
	[request addTarget:self action:@selector(googleFinished:) forRequestEvents:SMWebRequestEventComplete];
	[request start];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webRequestError:) name:kSMWebRequestError object:nil];
	
	ListController *home = [[ListController alloc] initListController];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:home];
	nav.toolbarHidden = NO;
	nav.toolbar.barStyle = UIBarStyleBlack;
	nav.navigationBar.barStyle = UIBarStyleBlack;
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:nav.view];
    [window makeKeyAndVisible];
}

- (void)googleFinished:(NSData *)responseData {
	NSLog(@"Got a response of %i bytes.", responseData.length);
}

- (void)webRequestError:(NSNotification *)notification {
	if (showedOfflineAlert) return;
	
	showedOfflineAlert = YES;	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"You appear to be offline." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alertView show];
}

@end
