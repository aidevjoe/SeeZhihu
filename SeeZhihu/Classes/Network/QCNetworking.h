//
//  QCNetworking.h
//  QCNetworking
//
//  Created by Joe on 16/9/12.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, QCNetworkStatus) {
    /**
     *  未知网络
     */
    QCNetworkStatusUnknown             = 1 << 0,
    /**
     *  无法连接
     */
    QCNetworkStatusNotReachable        = 1 << 1,
    /**
     *  WWAN网络
     */
    QCNetworkStatusReachableViaWWAN    = 1 << 2,
    /**
     *  WiFi网络
     */
    QCNetworkStatusReachableViaWiFi    = 1 << 3
};

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^QCSuccessBlock)(id returnData,int code,NSString *msg);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^QCFailureBlock)(NSError *error);


/**
 *  上传进度回调
 *
 *  @param progress 进度
 */
typedef void (^QCProgressBlock)(float progress);

/**
 *  多文件上传成功回调
 *
 *  @param response 成功后返回的数据
 */
typedef void(^QCMultUploadSuccessBlock)(NSArray *responses);

/**
 *  多文件上传失败回调
 *
 *  @param error 失败后返回的错误信息
 */
typedef void(^QCMultUploadFailureBlock)(NSArray *errors);


/**
 *  下载成功回调
 *
 *  @param returnData 数据
 */
typedef void (^QCDownloadSuccessBlock)(NSURL *fileUrl);


@interface QCNetworking : NSObject

/**
 * 检查网络
 */
+ (void)checkNetworkStatus;

/**
 *  当前网络 (需要先检查网络)
 *
 *  @return 当前网络
 */
+ (QCNetworkStatus)currentNetworkStatus;


#pragma mark - 发送 GET 请求

/**
 *   GET请求
 *
 *   @param url           url
 *   @param params        请求的参数字典
 *   @param cache         是否缓存
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (NSURLSessionTask *)getRequestWithUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  cache:(BOOL)isCache
                           successBlock:(QCSuccessBlock)successBlock
                           failureBlock:(QCFailureBlock)failureBlock
                                showHUD:(BOOL)showHUD;

#pragma mark - 发送 POST 请求

/**
 *   POST请求
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
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
                                 showHUD:(BOOL)showHUD;

#pragma mark - 文件上传

/**
 *  文件上传
 *
 *  @param url              上传文件接口地址
 *  @param params           请求的参数字典
 *  @param data             上传文件数据
 *  @param type             上传文件类型
 *  @param name             上传文件服务器文件夹名
 *  @param mimeType         mimeType (参考: http://www.iana.org/assignments/media-types/media-types.xhtml)
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
                                showHUD:(BOOL)showHUD;



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
                           showHUD:(BOOL)showHUD;


#pragma mark - 文件下载

/**
 *  文件下载 (带缓冲)
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
                              showHUD:(BOOL)showHUD;


@end




#pragma mark - 网络缓存

@interface QCNetworkCache : NSObject

/**
 *  对请求进行缓存
 *
 *  @param responseObject 需要缓存的数据
 *  @param requestUrl     请求url
 *  @param params         参数
 */
+ (void)cacheResponseObject:(id)responseObject
                 requestUrl:(NSString *)requestUrl
                     params:(NSDictionary *)params;

/**
 *  获取已缓存的请求
 *
 *  @param requestUrl 请求地址
 *  @param params     参数
 *
 *  @return 缓存的数据
 */
+ (id)getCacheResponseObjectWithRequestUrl:(NSString *)requestUrl
                                    params:(NSDictionary *)params;

/**
 *  对下载的数据进行缓存
 *
 *  @param data       下载的数据
 *  @param requestUrl 请求url
 */
+ (void)saveDownloadData:(NSData *)data
              requestUrl:(NSString *)requestUrl;

/**
 *  获取已缓存的下载数据
 *
 *  @param requestUrl 请求url
 *
 *  @return 缓存的url路径
 */
+ (NSURL *)getDownloadDataFromCacheWithRequestUrl:(NSString *)requestUrl;

/**
 *  获取磁盘缓存大小
 *
 *  @return 磁盘缓存大小
 */
+ (NSInteger)totalDiskCacheSize;

/**
 *  获取内存缓存大小
 *
 *  @return 内存缓存大小
 */
+ (NSInteger)totalMemoryCacheSize;

/**
 *  获取下载目录路径
 *
 *  @return 下载目录路径
 */
+ (NSString *)getDownDirectoryPath;

/**
 *  获取所有下载数据大小
 *
 *  @return 下载数据大小
 */
+ (NSUInteger)totalDownloadDataSize;

/**
 *  清除下载数据
 */
+ (void)clearDownloadData;

/**
 *  清除 内存、磁盘缓存
 */
+ (void)clearAllCache;

@end
