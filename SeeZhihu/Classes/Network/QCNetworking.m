//
//  QCNetworking.m
//  QCNetworking
//
//  Created by Joe on 16/9/12.
//  Copyright © 2016年 Joe. All rights reserved.
//


#import "QCNetworking.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <YYCache/YYCache.h>
#import <CommonCrypto/CommonDigest.h>
#import <QCLoadingView.h>
#import <QCMessageAlertView.h>

#define QC_ERROR_IMFORMATION @"网络错误，请检查网络连接"
#define QC_ERROR [NSError errorWithDomain:@"com.Joe78.QCNetworking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:QC_ERROR_IMFORMATION}]

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n方法:%s 行:%d 内容:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

static NSTimeInterval       requestTimeout = 20.f;
static QCNetworkStatus      networkStatus;
static AFHTTPSessionManager *_manager;

@interface QCNetworking ()

@property (nonatomic, copy) NSString *baseUrl;

@end

@implementation QCNetworking

+ (void)initialize{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //默认解析模式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //配置响应序列化
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    //请求超时时间
    manager.requestSerializer.timeoutInterval = requestTimeout;
    
    //检查网络
    [QCNetworking checkNetworkStatus];
    
    _manager = manager;
}

#pragma mark - 发送 GET 请求

/**
 *   GET请求
 *
 *   @param url           url
 *   @param params        请求的参数字典
 *   @param cache         是否缓存
 *   @param refresh       是否刷新
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (NSURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  cache:(BOOL)isCache
                                refresh:(BOOL)isRefresh
                           successBlock:(QCSuccessBlock)successBlock
                           failureBlock:(QCFailureBlock)failureBlock
                                showHUD:(BOOL)showHUD{
    
    __block NSURLSessionTask *session = nil;
    
    if (isCache) {
        
        id responseObject = [QCNetworkCache getCacheResponseObjectWithRequestUrl:url params:params];
        
        if (responseObject) {
            
            int code = 0;
            NSString *msg = nil;
            if (responseObject) {
                //这个字段取决于 服务器
                code                = [responseObject[@"rsCode"] intValue];
                msg                 = responseObject[@"rsMsg"];
            }
            successBlock ? successBlock(responseObject, code, msg) : 0;
            if (!isRefresh) return session;
        }
        
    }
    
    //没有网络直接返回
    if (networkStatus == QCNetworkStatusNotReachable) {
        [QCMessageAlertView showAlertWithMessage:QC_ERROR_IMFORMATION];
//        failureBlock ? failureBlock(QC_ERROR) : 0;
        return session;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];

    session = [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [QCLoadingView hideLoadingView];

        int code = 0;
        NSString *msg = nil;
        
        if (responseObject) {
            //这个字段取决于 服务器
            code                = [responseObject[@"rsCode"] intValue];
            msg                 = responseObject[@"rsMsg"];
        }
        successBlock ? successBlock(responseObject, code, msg) : 0;
        
        //缓存数据
        isCache ? [QCNetworkCache cacheResponseObject:responseObject requestUrl:url params:params] : 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QCLoadingView hideLoadingView];
        failureBlock ? failureBlock(error) : 0;
    }];
    
    [session resume];
    
    return session;
}


/**
 *   GET请求(自动缓存)
 *
 *   @param url           url
 *   @param params        请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (NSURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                           successBlock:(QCSuccessBlock)successBlock
                           failureBlock:(QCFailureBlock)failureBlock
                                showHUD:(BOOL)showHUD{
    
    __block NSURLSessionTask *session = nil;
    
    if (networkStatus == QCNetworkStatusNotReachable || networkStatus == 0) {
        
        [QCMessageAlertView showAlertWithMessage:QC_ERROR_IMFORMATION];
        failureBlock ? failureBlock(QC_ERROR) : 0;
        
        id responseObject = [QCNetworkCache getCacheResponseObjectWithRequestUrl:url params:params];
        
        if (responseObject) {
            
            int code = 0;
            NSString *msg = nil;
            if (responseObject) {
                //这个字段取决于 服务器
                code                = [responseObject[@"rsCode"] intValue];
                msg                 = responseObject[@"rsMsg"];
            }
            successBlock ? successBlock(responseObject, code, msg) : 0;
        }
        
        return session;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];
    
    session = [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [QCLoadingView hideLoadingView];
        
        int code = 0;
        NSString *msg = nil;
        
        if (responseObject) {
            //这个字段取决于 服务器
            code                = [responseObject[@"rsCode"] intValue];
            msg                 = responseObject[@"rsMsg"];
        }
        
        successBlock ? successBlock(responseObject, code, msg) : 0;
        
        [QCNetworkCache cacheResponseObject:responseObject requestUrl:url params:params];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QCLoadingView hideLoadingView];
        failureBlock ? failureBlock(error) : 0;
    }];
    
    [session resume];
    
    return session;
}

#pragma mark - 发送 POST 请求

/**
 *   POST请求
 *
 *   @param url           url
 *   @param params        请求的参数字典
 *   @param cache         是否缓存
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (NSURLSessionTask *)postRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                                   cache:(BOOL)isCache
                            successBlock:(QCSuccessBlock)successBlock
                            failureBlock:(QCFailureBlock)failureBlock
                                 showHUD:(BOOL)showHUD{
    
    __block NSURLSessionTask *session = nil;
    
    if (isCache) {
        
        id responseObject = [QCNetworkCache getCacheResponseObjectWithRequestUrl:url params:params];
        
        if (responseObject) {
            
            int code = 0;
            NSString *msg = nil;
            if (responseObject) {
                //这个字段取决于 服务器
                code                = [responseObject[@"rsCode"] intValue];
                msg                 = responseObject[@"rsMsg"];
            }
            successBlock ? successBlock(responseObject, code, msg) : 0;
        }
    }
    
    //没有网络直接返回
    if (networkStatus == QCNetworkStatusNotReachable) {
        failureBlock ? failureBlock(QC_ERROR) : 0;
        return session;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];
    
    session = [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [QCLoadingView hideLoadingView];

        int code = 0;
        NSString *msg = nil;
        if (responseObject) {
            //这个字段取决于 服务器
            code                = [responseObject[@"rsCode"] intValue];
            msg                 = responseObject[@"rsMsg"];
        }
        successBlock ? successBlock(responseObject, code, msg) : 0;
        
        //缓存数据
        isCache ? [QCNetworkCache cacheResponseObject:responseObject requestUrl:url params:params] : 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QCLoadingView hideLoadingView];

        failureBlock ? failureBlock(error) : 0;
    }];
    
    [session resume];
    
    return session;
}

#pragma mark - 文件上传

/**
 *  文件上传
 *
 *  @param url              上传文件接口地址
 *  @param params           请求的参数字典
 *  @param data             上传文件数据
 *  @param type             上传文件类型
 *  @param name             上传文件服务器文件夹名
 *  @param mimeType         mimeType
 *  @param progressBlock    上传文件路径
 *	@param successBlock     成功回调
 *	@param failBlock		失败回调
 *  @param showHUD          是否加载进度指示器
 *
 *  @return 返回的对象中可取消请求
 */
+ (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                               fileData:(NSData *)data
                                   type:(NSString *)type
                                   name:(NSString *)name
                               mimeType:(NSString *)mimeType
                          progressBlock:(QCProgressBlock)progressBlock
                           successBlock:(QCSuccessBlock)successBlock
                           failureBlock:(QCFailureBlock)failureBlock
                                showHUD:(BOOL)showHUD{
    
    __block NSURLSessionTask *session = nil;
    
    //没有网络直接返回
    if (networkStatus == QCNetworkStatusNotReachable) {
        failureBlock ? failureBlock(QC_ERROR) : 0;
        return session;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];
    
    session = [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = nil;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *day = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@.%@",day,type];
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progressBlock ? progressBlock((float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount) : 0;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [QCLoadingView hideLoadingView];
        
        int code = 0;
        NSString *msg = nil;
        if (responseObject) {
            //这个字段取决于 服务器
            code                = [responseObject[@"rsCode"] intValue];
            msg                 = responseObject[@"rsMsg"];
        }
        successBlock ? successBlock(responseObject, code, msg) : 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QCLoadingView hideLoadingView];
        
        failureBlock ? failureBlock(error) : 0;
    }];

    return session;
}

/**
 *  多文件上传
 *
 *  @param url              上传文件接口地址
 *  @param params           请求的参数字典
 *  @param data             上传文件数据
 *  @param type             上传文件类型
 *  @param name             上传文件服务器文件夹名
 *  @param mimeType         mimeType
 *  @param progressBlock    上传文件路径
 *	@param successBlock     成功回调
 *	@param failBlock		失败回调
 *  @param showHUD          是否加载进度指示器
 *
 *  @return 返回的对象中可取消请求
 */
+ (NSArray *)uploadMultFileWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                         fileDatas:(NSArray *)datas
                              type:(NSString *)type
                              name:(NSString *)name
                          mimeType:(NSString *)mimeTypes
                     progressBlock:(QCProgressBlock)progressBlock
                      successBlock:(QCMultUploadSuccessBlock)successBlock
                      failureBlock:(QCMultUploadFailureBlock)failureBlock
                           showHUD:(BOOL)showHUD{
    
    //没有网络直接返回
    if (networkStatus == QCNetworkStatusNotReachable) {
        failureBlock ? failureBlock(@[QC_ERROR]) : 0;
        return nil;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];

    __block NSMutableArray *sessions = [NSMutableArray array];
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    
    dispatch_group_t uploadGroup = dispatch_group_create();
    
    NSInteger count = datas.count;
    
    for (int i = 0; i < count; i++) {
        __block NSURLSessionTask *session = nil;

        dispatch_group_enter(uploadGroup);
        
        session = [self uploadFileWithUrl:url params:params fileData:datas[i] type:type name:name mimeType:mimeTypes progressBlock:^(float progress) {
            
            progressBlock ? progressBlock(progress) : 0;
            
        } successBlock:^(id returnData, int code, NSString *msg) {
            
            [responses addObject:returnData];
            dispatch_group_leave(uploadGroup);
            
        } failureBlock:^(NSError *error) {
            NSError *Error = [NSError errorWithDomain:url code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i]}];
            [failResponse addObject:Error];
            dispatch_group_leave(uploadGroup);
        } showHUD:showHUD];
        
        [session resume];
        
        if (session) [sessions addObject:session];
    }
    
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            [QCLoadingView hideLoadingView];
            successBlock ? (successBlock([responses copy])) : 0;
        }
        
        if (failResponse.count > 0) {
            [QCLoadingView hideLoadingView];
            failureBlock ? failureBlock([failResponse copy]) : 0;
        }
        
    });
    
    return [sessions copy];
    
}

#pragma mark - 文件下载

/**
 *  文件下载 (带缓存)
 *
 *  @param url           下载文件接口地址
 *  @param progressBlock 下载进度
 *  @param successBlock  成功回调
 *  @param failBlock     下载回调
 *  @param showHUD       是否加载进度指示器
 *
 *  @return 返回的对象可取消请求
 */
+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                        progressBlock:(QCProgressBlock)progressBlock
                         successBlock:(QCDownloadSuccessBlock)successBlock
                         failureBlock:(QCFailureBlock)failureBlock
                              showHUD:(BOOL)showHUD{
    
    __block NSURLSessionTask *session = nil;
    
    NSString *type = nil;
    NSArray *subStringArr = nil;
    
    NSURL *fileUrl = [QCNetworkCache getDownloadDataFromCacheWithRequestUrl:url];
    
    if (fileUrl) {
        if (successBlock) successBlock(fileUrl);
        return session;
    }
    
    //没有网络直接返回
    if (networkStatus == QCNetworkStatusNotReachable) {
        failureBlock ? failureBlock(QC_ERROR) : 0;
        return session;
    }
    
    if(showHUD) [QCLoadingView showLoadingView];
    
    if (url) {
        subStringArr = [url componentsSeparatedByString:@"."];
        if (subStringArr.count > 0) {
            type = subStringArr[subStringArr.count - 1];
        }
    }
    
    //响应内容序列化为二进制
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    session = [_manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progressBlock ? progressBlock((float)downloadProgress.completedUnitCount/(float)downloadProgress.totalUnitCount) : 0;

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [QCLoadingView hideLoadingView];
        
        if (successBlock) {
            NSData *data = (NSData *)responseObject;
            
            [QCNetworkCache saveDownloadData:data requestUrl:url];
            
            NSURL *downFileUrl = [QCNetworkCache getDownloadDataFromCacheWithRequestUrl:url];
            
            successBlock(downFileUrl);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [QCLoadingView hideLoadingView];
        
        failureBlock ? failureBlock(error) : 0;

    }];
    
    [session resume];
    
    return session;
}

#pragma makr - 检查网络
+ (void)checkNetworkStatus
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                networkStatus = QCNetworkStatusUnknown;
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                networkStatus = QCNetworkStatusNotReachable;
                NSLog(@"没有网络(断网)");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                networkStatus = QCNetworkStatusReachableViaWWAN;
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                networkStatus = QCNetworkStatusReachableViaWiFi;
                NSLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}

+ (QCNetworkStatus)currentNetworkStatus{
    return networkStatus;
}

@end







@implementation QCNetworkCache

//static NSString *const cacheDirKey = @"cacheDirKey";
static NSString *const downloadDirKey = @"downloadDirKey";
static YYCache  *cache;

+ (void)initialize{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"cacheDirKey"];
    cache = [YYCache cacheWithPath:path];
//    cache = [YYCache cacheWithName:cacheDirKey];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
}

+ (void)cacheResponseObject:(id)responseObject
                 requestUrl:(NSString *)requestUrl
                     params:(NSDictionary *)params{
    assert(responseObject);
    assert(requestUrl);
    
    if (!params) params = @{};
    NSString *originString = [NSString stringWithFormat:@"%@-%@",requestUrl,params];
    NSString *hash = [self md5:originString];
    
    [cache setObject:responseObject forKey:hash withBlock:^{
        NSLog(@"成功 hash = %@", hash);
    }];
}

+ (id)getCacheResponseObjectWithRequestUrl:(NSString *)requestUrl
                                    params:(NSDictionary *)params{
    assert(requestUrl);
    
    if (!params) params = @{};
    NSString *originString = [NSString stringWithFormat:@"%@-%@",requestUrl,params];
    NSString *hash = [self md5:originString];
    
    id cacheData = [cache objectForKey:hash];
    
    return cacheData;
}

+ (void)saveDownloadData:(NSData *)data
              requestUrl:(NSString *)requestUrl {
    assert(data);
    assert(requestUrl);
    
    NSString *fileName = nil;
    NSString *type = nil;
    NSArray *strArray = nil;
    
    strArray = [requestUrl componentsSeparatedByString:@"."];
    if (strArray.count > 0) {
        type = strArray[strArray.count - 1];
    }
    
    if (type) {
        fileName = [NSString stringWithFormat:@"%@.%@",[self md5:requestUrl],type];
    }else {
        fileName = [NSString stringWithFormat:@"%@",[self md5:requestUrl]];
    }
    
    NSString *directoryPath = nil;
    directoryPath = [[NSUserDefaults standardUserDefaults] objectForKey:downloadDirKey];
    if (!directoryPath) {
        directoryPath = [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"QCNetworking"] stringByAppendingPathComponent:@"download"];
        
        [[NSUserDefaults standardUserDefaults] setObject:directoryPath forKey:downloadDirKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    if (error) {
        NSLog(@"创建目录错误: %@",error.localizedDescription);
        return;
    }
    
    NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

+ (NSURL *)getDownloadDataFromCacheWithRequestUrl:(NSString *)requestUrl {
    
    assert(requestUrl);
    
    NSData *data = nil;
    NSString *fileName = nil;
    NSString *type = nil;
    NSArray *strArray = nil;
    NSURL *fileUrl = nil;
    
    strArray = [requestUrl componentsSeparatedByString:@"."];
    if (strArray.count > 0) {
        type = strArray[strArray.count - 1];
    }
    
    if (type) {
        fileName = [NSString stringWithFormat:@"%@.%@",[self md5:requestUrl],type];
    }else {
        fileName = [NSString stringWithFormat:@"%@",[self md5:requestUrl]];
    }
    
    
    NSString *directoryPath = [[NSUserDefaults standardUserDefaults] objectForKey:downloadDirKey];
    
    if (directoryPath){
        NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
        data = [[NSFileManager defaultManager] contentsAtPath:filePath];
    }
    
    if (data) {
        NSString *path = [directoryPath stringByAppendingPathComponent:fileName];
        fileUrl = [NSURL fileURLWithPath:path];
    }
    
    return fileUrl;
}


+ (NSInteger)totalDiskCacheSize{
    return [cache.diskCache totalCost];
}

+ (NSInteger)totalMemoryCacheSize{
    return [cache.memoryCache totalCost];
}

+ (NSString *)getDownDirectoryPath{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:downloadDirKey];
}

+ (NSUInteger)totalDownloadDataSize{
    NSString *diretoryPath = [[NSUserDefaults standardUserDefaults] objectForKey:downloadDirKey];
    
    if (!diretoryPath) return 0;
    
    BOOL isDir = NO;
    NSUInteger total = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:diretoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:diretoryPath error:&error];
            if (!error) {
                for (NSString *subFile in array) {
                    NSString *filePath = [diretoryPath stringByAppendingPathComponent:subFile];
                    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
                    
                    if (!error) {
                        total += [attributes[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

+ (void)clearDownloadData{
    NSString *diretoryPath = [[NSUserDefaults standardUserDefaults] objectForKey:downloadDirKey];
    if (diretoryPath) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:diretoryPath isDirectory:nil]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:diretoryPath error:&error];
            if (error) {
                NSLog(@"清理缓存是出现错误：%@",error.localizedDescription);
            }
        }
    }
}

+ (void)clearAllCache{
    [cache removeAllObjectsWithBlock:^{
        NSLog(@"缓存清除成功");
    }];
}


#pragma mark - 散列值
+ (NSString *)md5:(NSString *)string {
    if (string == nil || string.length == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH],i;
    
    CC_MD5([string UTF8String],(int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding],digest);
    
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x",(int)(digest[i])];
    }
    
    return [ms copy];
}

@end


