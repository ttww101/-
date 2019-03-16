//
//  startController.h
//  testProject
//
//  Created by 欣创 on 2019/3/8.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface startController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *teamALable;
@property (nonatomic, weak) IBOutlet UILabel *teamBLable;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *ScoreALabel;
@property (nonatomic, weak) IBOutlet UILabel *ScoreBLabel;
@property (nonatomic, weak) IBOutlet UIButton *addScoreABtn;
@property (nonatomic, weak) IBOutlet UIButton *lessScoreABtn;
@property (nonatomic, weak) IBOutlet UIButton *addScoreBBTn;
@property (nonatomic, weak) IBOutlet UIButton *lessScoreBBtn;

@end


