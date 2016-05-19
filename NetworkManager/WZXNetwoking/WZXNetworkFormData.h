//
//  WZXNetworkFormData.h
//  NetworkManager
//
//  Created by WzxJiang on 16/5/19.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WZXNetworkFormData : NSObject

/**
 *  data
 */
@property(nonatomic,copy) NSData * data;

/**
 *  名字
 */
@property(nonatomic,copy)NSString * name;

/**
 *  文件名
 */
@property(nonatomic,copy)NSString * fileName;

/**
 *  文件类型
 */
@property(nonatomic,copy)NSString * mimeType;
/**
 *  快速创建
 */
+ (nonnull WZXNetworkFormData *)formDataWithData:(nonnull NSData *)data name:(nonnull NSString *)name fileName:(nonnull NSString *)fileName mimeType:(nonnull NSString *)mimeType;

+ (nonnull WZXNetworkFormData *)formDataWithImg:(nonnull UIImage *)image name:(nonnull NSString *)name fileName:(nonnull NSString *)fileName scale:(CGFloat)scale;
@end
