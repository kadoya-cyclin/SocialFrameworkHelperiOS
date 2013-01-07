SocialFrameworkHelperiOS
========================

SocialFrameworkHelperiOS can be used easily for SocialFramework for iOS.
It is built on top of Social.framework and Twitter.framework and other familiar Foundation technologies.
It has the API to avoid the implementation of the Framework in using these cumbersome.
For example, here's how easy it is to post Twitter with Article and Link from UIWebView.  

```objectivec
_socialFrameworkHelper = [SocialFrameworkHelper sharedHelper];
[_socialFrameworkHelper setDelegate:self]

UIViewController *twitterPostVC = [_socialFrameworkHelper postWebViewDataToTwitter:_webView];
[self presentViewController:twitterPostVC animated:YES completion:^{
  NSLog(@"Finished Tweet");
}];
```
Please try to see the following sentence has a variety of functions more.

  
How To Get Started
---------
+ Download SocialFrameworkHelperiOS and try out the included iPhone example app.
+ Read this Document to check the APIs available in SocialFrameworkHelperiOS.

  
How To Include It
-------------
+ Copy SocialFramework.h and SocialFramework.m into your Project.
  
+ Add following Frameworks to your project's Link Binary With Libraries build phase.  
        Twitter.framework (mark it optional, new in iOS6)  
        Social.framework (mark it optional)
  
Example Usage
-----------------
####PostTwitter using UIWebView's data. (Webpage title, and link)
  
```objectivec
UIViewController *twitterPostVC = [_socialFrameworkHelper postWebViewDataToTwitter:_webView];
[self presentViewController:twitterPostVC animated:YES completion:^{

}];
```
  
####Post Facebook using UIWebView's data. (Webpage title, and link)
  
```objectivec
UIViewController *facebookPostVC = [_socialFrameworkHelper postWebViewDataToFacebook:_webView];
if(!facebookPostVC){
	// Cannot use this function in iOS5
	UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Cannot use this function previous versions of iOS" message:@"Please update previous versions iOS to latest versions iOS" delegate:nil cancelButtonTitle:@"OK"];
	[alert show];
	return;
}
[self presentViewController:facebookPostVC animated:YES completion:^{
	
}];  
```
  
####Post Twitter using your setting data
  
```objectivec
NSURL *postURL = [NSURL URLWithString:@"http://google.com"];
UIImage *postImage = [UIImage imageNamed:@"testImage.png"];
 UIViewController *postTwitterVC = [_socialFrameworkHelper postTwitterText:@"Google" withURL:postURL withMedia:postImage];
[self presentViewController:twitterPostVC animated:YES completion:^{
	
}];
```
  
####Post Facebook using your setting data
  
```objectivec
NSURL *postURL = [NSURL URLWithString:@"http://google.com"];
UIImage *postImage = [UIImage imageNamed:@"testImage.png"];
UIViewController *postFacebookVC = [_socialFrameworkHelper postFacebookText:@"Google" withURL:postURL withMedia:postImage];
if(!facebookPostVC){
	// Cannot use this function in iOS5
	UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Cannot use this function previous versions of iOS" message:@"Please update previous versions iOS to latest versions iOS" delegate:nil cancelButtonTitle:@"OK"];
	[alert show];
	return;
}
[self presentViewController:facebookPostVC animated:YES completion:^{
	
}];  
```
  
####Callback
  
````objectivec
-(void)socialFWHTwitterPostDone:(SocialFrameworkHelper *)socialFrameworkHelper;
-(void)socialFWHTwitterPostCanceled:(SocialFrameworkHelper *)socialFrameworkHelper;
-(void)socialFWHFacebookPostDone:(SocialFrameworkHelper *)socialFrameworkHelper;
-(void)socialFWHFacebookPostCanceled:(SocialFrameworkHelper *)socialFrameworkHelper;
```
  
Credits
-----------
SocialFrameworkHelperiOS was created by Shota Kondou([@cyclin_devel](https://twitter.com/cyclin_devel)) in development of [NewsClock](http://www.cyclin.jp/products/newsclock.html).
  
License
-----------
SocialFrameworkHelperiOS is available under the MIT license. See the LICENSE file for more info.
