//
//  FullData.h
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FullData : NSObject

//static method
+ (instancetype)shared;

//全域變數
@property (strong, nonatomic) NSString *TeamA;
@property (strong, nonatomic) NSString *TeamB;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *people;
@property (strong, nonatomic) NSString *etc;

@property (strong, nonatomic) NSString *totalTime;
@property (strong, nonatomic) NSString *scoreA;
@property (strong, nonatomic) NSString *scoreB;

@property (strong, nonatomic) NSMutableArray *gameInfo;

@end

NS_ASSUME_NONNULL_END
