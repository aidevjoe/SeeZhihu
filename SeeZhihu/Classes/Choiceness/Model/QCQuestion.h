//
//  QCQuestion.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCQuestion : NSObject

@property (nonatomic, copy) NSString *summary; /**< 答案摘要 */

@property (nonatomic, copy) NSString *avatar; /**< 答主头像url */

@property (nonatomic, copy) NSString *time; /**< 发表时间 */

@property (nonatomic, copy) NSString *title; /**< 文章id */

@property (nonatomic, copy) NSString *questionid; /**< 问题id，8位数字 */

@property (nonatomic, copy) NSString *authorname; /**< 答主名称 */

@property (nonatomic, copy) NSString *vote; /**< 赞同票数 */

@property (nonatomic, copy) NSString *answerid; /**< 答案id，8~9位数字 */

@property (nonatomic, copy) NSString *authorhash; /**< 答主hash */

@end

