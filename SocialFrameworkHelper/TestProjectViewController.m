//
// TestProjectViewController.m
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

#import "TestProjectViewController.h"
#import "SocialFrameworkHelper.h"

@interface TestProjectViewController ()

@end

@implementation TestProjectViewController
#pragma mark -- Initialization Code --
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([self checkCurrentDeviceiPhone5]) {
        // iPhone5
        self = [super initWithNibName:@"TestProjectViewController" bundle:nil];
    }else{
        // iPhone4
        self = [super initWithNibName:@"TestProjectViewControlleriPhone4" bundle:nil];
    }
    
    if (self) {
        // Custom initialization...
        
    }
    return self;
}

#pragma mark -- Views LifeCycle --
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // SetUp SocialFrameworkViewController
    _socialFrameworkHelper = [SocialFrameworkHelper sharedHelper];
    [_socialFrameworkHelper setDelegate:self];
    
    // Loading GoogleWebSite
    [_webView setDelegate:self];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIWebViewDelegate --
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark -- SocialFrameworkHelper Delegate --
-(void)socialFWHTwitterPostCanceled:(SocialFrameworkHelper *)socialFrameworkHelper{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)socialFWHTwitterPostDone:(SocialFrameworkHelper *)socialFrameworkHelper{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)socialFWHFacebookPostCanceled:(SocialFrameworkHelper *)socialFrameworkHelper{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)socialFWHFacebookPostDone:(SocialFrameworkHelper *)socialFrameworkHelper{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -- Outlets Actions --
- (IBAction)twitterButtonPushed:(id)sender {
    UIViewController *twitterPostVC = [_socialFrameworkHelper postWebViewDataToTwitter:_webView];
    [self presentViewController:twitterPostVC animated:YES completion:^{
        
    }];
}

- (IBAction)facebookButtonPushed:(id)sender {
    UIViewController *facebookPostVC = [_socialFrameworkHelper postWebViewDataToFacebook:_webView];
    
    if (!facebookPostVC) {
        // cannot use this function in iOS5
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot use this function" message:@"Cannot use this function before iOS6.\r\nPlease update iOS5 to iOS6!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self presentViewController:facebookPostVC animated:YES completion:^{
        
    }];
}

#pragma mark -- Check iPhone5 or iPhone4 --
-(BOOL)checkCurrentDeviceiPhone5{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return height > 500? YES: NO;
}
@end
