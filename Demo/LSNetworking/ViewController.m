//
//  ViewController.m
//  LSNetworking
//
//  Created by ThoamsTan on 16/8/1.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "ViewController.h"
#import "LSNetworking.h"
#define rootURL @"http://192.168.111.199/VipaWebApi"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LSNetworking sharedNetworking] GET:[NSString stringWithFormat:@"%@%@",rootURL,@"/Consultant/GetCashSettlements"] parameters:@{} success:^(NSDictionary *responseDictionary) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
