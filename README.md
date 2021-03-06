# WZXNetworking
基于AFNetwoking，使用链式编程思想的网络请求框架的示例

# 为什么封装WZXNetworking
这是一个容错性非常吓人的框架。
它是采用链式编程思想封装。
```objc
[[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001")
.RequestType(POST).HTTPHeader(nil).Parameters(nil)
.RequestSerialize(RequestSerializerHTTP).ResponseSerialize(ResponseSerializerJSON).FormData(formData) startRequestWithProgress:^(NSProgress *progress) {
        NSLog(@"%f",progress.fractionCompleted);
    } success:^(id response) {
        NSLog(@"success");
    } failure:^{
        NSLog(@"failure");
    }];
```
在这里除了`.setRequest(url)`和`startRequestWithSuccess failure`方法，其他都是不必要的。
你可以这样:
```objc
[[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001") startRequestWithSuccess:^(id response) {
       
        NSLog(@"success");
    } failure:^{
        
        NSLog(@"failure");
    }];
```
链式在**参数和参数的选择很多的情况**或者**很有可能改动的情况**下展现了惊人的优势。因为，它的改动十分方便，只不过添加或者修改一个方法。

## 打个比方：
#### 换成集中式API封装应该是这样的:
```objc
- (void)GET:(NSString *)url
        parameters:(id)Parameters
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;
```
当你要添加一个Version属性做API版本判断的时候，你能怎么办？只能重写方法，在方法中加入一个Version参数，然后所有使用的网络请求都要改变方法。
#### 换成分布式API封装我们则不考虑对比了..
```objc
GeneralAPI *apiGeGet            = [[GeneralAPI alloc] initWithRequestMethod:@"get"];
apiGeGet.apiRequestMethodType      = RequestMethodTypeGET;
apiGeGet.apiRequestSerializerType  = RequestSerializerTypeHTTP;
apiGeGet.apiResponseSerializerType = ResponseSerializerTypeHTTP;
[apiGeGet setApiCompletionHandler:^(id responseObject, NSError * error) {
    NSLog(@"responseObject is %@", responseObject);
    if (error) {
        NSLog(@"Error is %@", error.localizedDescription);
    }
}];
[apiGeGet start];
```
这样的结构是否太松散？

#### 再换成WZXNetworking
我们要做的只是再添加一个方法和一个成员变量，然后在原有方法后面加一个.method()
```objc
- (WZXNetworkManager * (^) (id some))method {
  return ^WZXNetworkManager (id some) {
     self.XXX = some
     return self;
  }
}
```
```objc
[[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001").method() startRequestWithSuccess:^(id response) {
       
        NSLog(@"success");
    } failure:^{
        
        NSLog(@"failure");
    }];
```

## 更新
- 16.05.19: 增加post加formdata的参数
 ```objc
    WZXNetworkFormData * formData = [WZXNetworkFormData formDataWithImg:image name:@"img" fileName:@"image" scale:1];
    // or
    // WZXNetworkFormData * formData = [WZXNetworkFormData formDataWithData:xxx name:name fileName:fileName mimeType:mimeType];

    [[WZXNetworkManager manager].setRequest(@"http://192.168.1.40:8001").FormData(formData) startRequestWithSuccess:^(id response) {
        NSLog(@"success");
    } failure:^{
        NSLog(@"failure");
    }];

 ```
 
- 16.5.24 增加发送请求API，包含上传、下载进度的回调。
 ```objc
 /**
 *  发送请求(带进度)，仅限POST、GET
 *
 *  @param progress 下载或上传进度的回调
 *  @param success  成功的回调
 *  @param failure  失败的回调
 */
- (void)startRequestWithProgress:(void(^)(NSProgress * progress))progress success:(void(^)(id response))success failure:(void (^)())failure;
 ``` 
- 16.5.29 修复get和post不能同时用的BUG

