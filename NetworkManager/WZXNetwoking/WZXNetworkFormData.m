//
//  WZXNetworkFormData.m
//  NetworkManager
//
//  Created by WzxJiang on 16/5/19.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXNetworkFormData.h"

@implementation WZXNetworkFormData

+ (WZXNetworkFormData *)formDataWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
    WZXNetworkFormData * dataObj = [[WZXNetworkFormData alloc]init];
    dataObj.data = data;
    dataObj.name = name;
    dataObj.fileName = fileName;
    dataObj.mimeType = mimeType;
    return dataObj;
}

+ (WZXNetworkFormData *)formDataWithImg:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName scale:(CGFloat)scale {
    WZXNetworkFormData * dataObj = [[WZXNetworkFormData alloc]init];
    if (UIImagePNGRepresentation(image) == nil) {
        dataObj.data = UIImageJPEGRepresentation(image, scale);
        dataObj.mimeType = @"JPEG";
    }else {
        dataObj.data = UIImagePNGRepresentation(image);
        dataObj.mimeType = @"PNG";
    }
    dataObj.name = name;
    dataObj.fileName = fileName;
    return dataObj;
}
@end
