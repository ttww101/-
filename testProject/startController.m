//
//  startController.m
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "startController.h"
#import "FullData.h"


@interface startController ()

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) float accumulatedTime;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation startController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        self.teamALable.text = [FullData shared].TeamA;
        self.teamBLable.text = [FullData shared].TeamB;
    
    self.startBtn.layer.cornerRadius = 10;
    self.startBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    self.resetBtn.layer.cornerRadius = 10;
    self.resetBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    self.saveBtn.layer.cornerRadius = 10;
    self.saveBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    self.accumulatedTime = 0;
    
    self.addScoreABtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *addScoreA =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addScoreA:)];
    [self.addScoreABtn addGestureRecognizer:addScoreA];
    
    self.lessScoreABtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *lessScoreA =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lessScoreA:)];
    [self.lessScoreABtn addGestureRecognizer:lessScoreA];
    
    self.addScoreBBTn.userInteractionEnabled = YES;
    UITapGestureRecognizer *addScoreB =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addScoreB:)];
    [self.addScoreBBTn addGestureRecognizer:addScoreB];
    
    self.lessScoreBBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *lessScoreB =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lessScoreB:)];
    [self.lessScoreBBtn addGestureRecognizer:lessScoreB];
}

-(void)updateTime:(NSTimer *)timer
{
    self. accumulatedTime++;
   
    NSInteger tempHour = self.accumulatedTime / 3600;
    NSInteger tempMinute = self.accumulatedTime / 60 - (tempHour * 60);
    NSInteger tempSecond = self.accumulatedTime - (tempHour * 3600 + tempMinute * 60);
    
    NSString *hour = [[NSNumber numberWithInteger:tempHour] stringValue];
    NSString *minute = [[NSNumber numberWithInteger:tempMinute] stringValue];
    NSString *second = [[NSNumber numberWithInteger:tempSecond] stringValue];
    if (tempHour < 10) {
        hour = [@"0" stringByAppendingString:hour];
    }
    if (tempMinute < 10) {
        minute = [@"0" stringByAppendingString:minute];
    }
    if (tempSecond < 10) {
        second = [@"0" stringByAppendingString:second];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
}

-(IBAction)addScoreA:(id) sender{
    int temp = [self.ScoreALabel.text intValue];
    NSString *a = [@((temp +1)) stringValue];
    self.ScoreALabel.text = a;
}

-(IBAction)lessScoreA:(id) sender{
    int temp = [self.ScoreALabel.text intValue];
    if((temp -1) < 0){
        self.ScoreALabel.text = @"0";
    } else{
        NSString *a = [@((temp -1)) stringValue];
        self.ScoreALabel.text = a;
    }
}

-(IBAction)addScoreB:(id) sender{
    int temp = [self.ScoreBLabel.text intValue];
    NSString *a = [@((temp +1)) stringValue];
    self.ScoreBLabel.text = a;
}

-(IBAction)lessScoreB:(id) sender{
    int temp = [self.ScoreBLabel.text intValue];
    if((temp -1) < 0){
        self.ScoreBLabel.text = @"0";
    } else{
        NSString *a = [@((temp -1)) stringValue];
        self.ScoreBLabel.text = a;
    }
}

-(IBAction)startGame{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

-(IBAction)resetGame{
    
    self.accumulatedTime = 0;
    self.timeLabel.text = @"00:00:00";
    
    [self.timer invalidate];
    self.timer = nil;
}

-(IBAction)saveGame{
    
    [FullData shared].totalTime = self.timeLabel.text;
    [FullData shared].scoreA = self.ScoreALabel.text;
    [FullData shared].scoreB = self.ScoreBLabel.text;
    
    //NSArray *Game = [[NSArray alloc] initWithObjects:[FullData shared].TeamA, [FullData shared].TeamB, [FullData shared].scoreA, [FullData shared].scoreB, nil];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                [FullData shared].TeamA, @"TeamA",
                                [FullData shared].TeamB, @"TeamB",
                                [FullData shared].scoreA, @"scoreA",
                                [FullData shared].scoreB, @"scoreB",
                                nil];
    
    [[FullData shared].gameInfo addObject:att];
    
    //[[FullData shared].gameInfo addObject:Game];
    
    //NSLog(@"GAME：%@",Game);
    //NSLog(@"gameInfo：%@", [FullData shared].gameInfo);

    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

@end
