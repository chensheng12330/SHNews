//
//  WebViewController.m
//  AFNetworking iOS Example
//
//  Created by sherwin.chen on 15-6-17.
//  Copyright (c) 2015年 Gowalla. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *addressURL;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    
    
    //
    
    self.addressURL = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.url];
    
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]] ];
    
    
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.addressURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if (connectionError==NULL) {
         
            NSDictionary *infoData = [data objectFromJSONData];
            
            NSDictionary *allVal = infoData[self.url];
            
            NSString *body = allVal[@"body"];
            
            [self.webView loadHTMLString:body baseURL:[NSURL URLWithString:self.addressURL]];
        }
       
    }];
    
}

@end
