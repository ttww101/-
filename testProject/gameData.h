//
//  gameData.h
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameData : NSObject
{
    //成员变量
@public //自己和外部成员均可访问
    int age;
    
@public //自己内部访问
    float height;
    
@public //子类和自己可以访问
    NSString *teamA;
    NSString *teamB;
}

//对象方法和类方法
-(id) init;
//init一般为构造方法
-(id)initWithAge:(int)newAge;
-(id)initWithAge:(int)newAge andHeight:(float)newHeight;

-(void)setAge:(int)newAge;
-(void)setHeigt:(float)newHeight;
-(void)setAge:(int)newAge AndHeight:(float)newHeight;

-(int)getAge;
-(float)getHeight;

-(void) setTeam:(NSString*)nTeamA AndTeamB:(NSString*)nTeamB;

-( NSString* )getTeamA;
-( NSString* )getTeamB;

@end
