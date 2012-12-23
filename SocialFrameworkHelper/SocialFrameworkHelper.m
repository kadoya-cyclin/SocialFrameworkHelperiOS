//
// SocialFrameworkHelper.m
// SocialFrameworkHelper
//
// Copyright (c) 2012 Shota Kondou, Cyclin. and FOU.Inc.
// http://cyclin.jp
// http://fou.co.jp
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SocialFrameworkHelper.h"

// Set "Link Binary With Libraries" 'Optional'!!
#import <Social/Social.h>
#import <Twitter/Twitter.h>

#define kPostedByServiceName @"by SocialFrameworkHelper"

@implementation SocialFrameworkHelper
#pragma mark -- Initialization Code --
+(SocialFrameworkHelper *)sharedHelper{
    static SocialFrameworkHelper *_socialFrameworkHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _socialFrameworkHelper = [[SocialFrameworkHelper alloc] init];
    });
    
    return _socialFrameworkHelper;
}

-(id)init{
    self = [super init];
    if (self) {
        // Initialization Code Here...
        
    }
    
    return self;
}

#pragma mark -- HelperMethods --
-(UIViewController *)postTwitterText:(NSString *)postText withURL:(NSURL *)postURL withMedia:(UIImage *)postImage{
    if ([SocialFrameworkHelper checkiOS6]) {
        // iOS6 => socialFramework
        return [self postTwitteriniOS6:postText withURL:postURL withMedia:postImage];
    }else{
        // iOS5 => twitterFramework
        return [self postTwitteriniOS5:postText withURL:postURL withMedia:postImage];
    }
}

-(UIViewController *)postFacebookText:(NSString *)postText withURL:(NSURL *)postURL withMedia:(UIImage *)postImage{
    if ([SocialFrameworkHelper checkiOS6]) {
        // iOS6
        return [self postFaceBookiniOS6:postText withURL:postURL withMedia:postImage];
    }else{
        // iOS5 => cannot use SocialFramework...
        return nil;
    }
}

-(UIViewController *)postTwitteriniOS6:(NSString *)postText withURL:(NSURL *)postURL withMedia:(UIImage *)postImage{
    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Add Servicename to postText
    NSString *appendedServiceNameText = [NSString stringWithFormat:@"%@\r\n%@",postText,kPostedByServiceName];
    
    [twitterPostVC setInitialText:appendedServiceNameText];
    if (postURL) {
        [twitterPostVC addURL:postURL];
    }
    
    if (postImage) {
        [twitterPostVC addImage:postImage];
    }
    
    twitterPostVC.completionHandler = ^(SLComposeViewControllerResult res){
        if (res == SLComposeViewControllerResultCancelled) {
            // Canceled
            if ([_delegate respondsToSelector:@selector(socialFWHTwitterPostCanceled:)]) {
                [_delegate socialFWHTwitterPostCanceled:self];
            }
        }else{
            // Done
            if ([_delegate respondsToSelector:@selector(socialFWHTwitterPostDone:)]) {
                [_delegate socialFWHTwitterPostDone:self];
            }
        }
    };
    
    return twitterPostVC;
}

-(UIViewController *)postTwitteriniOS5:(NSString *)postText withURL:(NSURL *)postURL withMedia:(UIImage *)postImage{
    TWTweetComposeViewController *twitterSendVC = [[TWTweetComposeViewController alloc] init];
    
    // Add Servicename to postText
    NSString *appendedServiceNameText = [NSString stringWithFormat:@"%@\r\n%@",postText,kPostedByServiceName];
    [twitterSendVC setInitialText:appendedServiceNameText];
    
    if (postURL) {
        [twitterSendVC addURL:postURL];
    }
    
    if (postImage) {
        [twitterSendVC addImage:postImage];
    }
    
    twitterSendVC.completionHandler = ^(TWTweetComposeViewControllerResult res){
        if (res == TWTweetComposeViewControllerResultDone) {
            if ([_delegate respondsToSelector:@selector(socialFWHTwitterPostDone:)]) {
                [_delegate socialFWHTwitterPostDone:self];
            }
        }else if (res == TWTweetComposeViewControllerResultCancelled){
            if ([_delegate respondsToSelector:@selector(socialFWHTwitterPostCanceled:)]) {
                [_delegate socialFWHTwitterPostCanceled:self];
            }
        }
    };
    
    return twitterSendVC;
}

-(UIViewController *)postFaceBookiniOS6:(NSString *)postText withURL:(NSURL *)postURL withMedia:(UIImage *)postImage{
    NSLog(@"%s",__func__);
    SLComposeViewController *facebookSendVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    // Add ServiceName to PostText
    NSString *appendedServiceName = [NSString stringWithFormat:@"%@\r\n%@",postText,kPostedByServiceName];
    [facebookSendVC setInitialText:appendedServiceName];
    
    if (postURL) {
        [facebookSendVC addURL:postURL];
    }
    
    if (postImage) {
        [facebookSendVC addImage:postImage];
    }
    
    facebookSendVC.completionHandler = ^(SLComposeViewControllerResult res){
        if (res == SLComposeViewControllerResultCancelled) {
            if ([_delegate respondsToSelector:@selector(socialFWHFacebookPostCanceled:)]) {
                [_delegate socialFWHFacebookPostCanceled:self];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(socialFWHFacebookPostDone:)]) {
                [_delegate socialFWHFacebookPostDone:self];
            }
        }
    };
    
    return facebookSendVC;
}

-(UIViewController *)postWebViewDataToTwitter:(UIWebView *)webView{
    return [self postTwitterText:[SocialFrameworkHelper checkWebViewPageTitleString:webView] withURL:[SocialFrameworkHelper checkWebViewPageURL:webView] withMedia:nil];
}

-(UIViewController *)postWebViewDataToFacebook:(UIWebView *)webView{
    return [self postFacebookText:[SocialFrameworkHelper checkWebViewPageTitleString:webView] withURL:[SocialFrameworkHelper checkWebViewPageURL:webView] withMedia:nil];
}

#pragma mark -- Helper Methods --
+(BOOL)checkiOS6{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return (version < 6.0f)? NO: YES;
}

+(NSURL *)checkWebViewPageURL:(UIWebView *)webView{
    NSString *thisURLString = [webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    return [NSURL URLWithString:thisURLString];
}

+(NSString *)checkWebViewPageTitleString:(UIWebView *)webView{
    return [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
@end
