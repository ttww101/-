//
//  FullData.m
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "FullData.h"

@interface FullData ()

@end

@implementation FullData

+ (instancetype)shared {
    static FullData *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[FullData alloc] init];
        // Do any other initialisation stuff here
    });
    return shared;
}

@end
