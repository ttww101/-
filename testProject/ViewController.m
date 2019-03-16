//
//  ViewController.m
//  testProject
//
//  Created by 欣创 on 2019/3/5.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "ViewController.h"
#import "FullData.h"
#import "mapController.h"

@interface ViewController ()

@property(nonatomic,strong) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *startGameButtom;
@property (weak, nonatomic) IBOutlet UILabel *mapLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.background setImage:[UIImage imageNamed: @"background"]];
    self.startGameButtom.layer.cornerRadius= 15;
    self.locationText.layer.cornerRadius = 5;
    self.locationText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.locationText.text = @"點擊選擇你的地點";
    
    self.mapLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tomap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tomap:)];
    [self.mapLab addGestureRecognizer:tomap];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    /*
    self.teamAText.text = nil;
    self.teamBText.text = nil;
    self.timeText.text = nil;
    self.peopleText.text = nil;
    self.etcText.text = nil;
    self.locationText.text = @"點擊選擇你的地點";
    */
}

-(void)viewDidAppear:(BOOL)animated{
    if([FullData shared].location != nil)
    {
        self.locationText.text = [FullData shared].location;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(IBAction)getVarfromText{
    
    [FullData shared].TeamA = self.teamAText.text;
    [FullData shared].TeamB = self.teamBText.text;
    [FullData shared].time = self.timeText.text;
    [FullData shared].people = self.peopleText.text;
    [FullData shared].etc = self.etcText.text;
}

-(IBAction)tomap:(id) sender{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Map" bundle:[NSBundle mainBundle]];
    mapController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"mapController"];
    [self.navigationController pushViewController:controllerD animated:YES];
}

@end
