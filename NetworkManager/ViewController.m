//
//  ViewController.m
//  NetworkManager
//
//  Created by wordoor－z on 16/4/14.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "WZXNetworkManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"1.JPG"];
    
    WZXNetworkFormData * formData = [WZXNetworkFormData formDataWithImg:image
    name:@"img" fileName:@"image" scale:1];
    
    [[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001").RequestType(POST).HTTPHeader(nil).Parameters(nil).RequestSerialize(RequestSerializerHTTP).ResponseSerialize(ResponseSerializerJSON).FormData(formData) startRequestWithProgress:^(NSProgress *progress) {
        NSLog(@"%f",progress.fractionCompleted);
    } success:^(id response) {
        NSLog(@"success");
    } failure:^(NSError * error){
        NSLog(@"failure");
    }];
    
    [[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001") startRequestWithSuccess:^(id response) {
        NSLog(@"success");
    } failure:^(NSError * error){
        NSLog(@"failure");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
