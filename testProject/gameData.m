//
//  gameData.m
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "gameData.h"

@interface gameData()

@property (nonatomic, strong) NSString *str1;
@property (nonatomic, assign) int i;

@end

@implementation gameData

-(void)setAge:(int)newAge
{
    NSString *str2 = @"";
    NSString *str1 = [NSString stringWithFormat:@"123"];
    age = newAge;
}
-(void)setHeigt:(float)newHeight
{
    height = newHeight;
}
-(void)setAge:(int)newAge AndHeight:(float)newHeight
{
    age = newAge;
    height = newHeight;
}
-(int)getAge
{
    return age;
}

-(float)getHeight
{
    return height;
}

-(void) setTeam:(NSString*)nTeamA AndTeamB:(NSString*)nTeamB
{
    teamA = nTeamA;
    teamB = nTeamB;
}

-( NSString* )getTeamA
{
    return teamA;
}

-( NSString* )getTeamB
{
    return teamB;
}

@end
