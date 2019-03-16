//
//  mapController.m
//  testProject
//
//  Created by 欣创 on 2019/3/13.
//  Copyright © 2019年 欣创. All rights reserved.
//

#import "mapController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "FullData.h"

@interface mapController () <MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate>

@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (strong, nonatomic) AMapSearchAPI *searchPoi;
@property (strong, nonatomic) AMapReGeocodeSearchRequest *regeo;

//显示中心点经纬度的地址
@property (strong, nonatomic) UIButton *poiButton;
//当前位置地址
@property (strong, nonatomic) NSString *nowStr;
//中心点大头针
@property (strong, nonatomic) UIImageView *centerImgView;
//中心点经纬度结构体
//这个就是当前地图中心店的经纬度，如果需要使用这个经纬度，可以直接用这个属性
@property (assign, nonatomic) CLLocationCoordinate2D centerCoor;

@property CGFloat *kScreenWidth;
@property CGFloat *kScreenHeight;

@end

@implementation mapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    _kScreenWidth = &screenRect.size.width;
    _kScreenHeight = &screenRect.size.height;
    
    //地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, *(_kScreenWidth), *(_kScreenHeight))];
    self.mapView.delegate = self; //遵循代理<MAMapViewDelegate>
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    tap.delegate = self; //一定要记得设置代理
    
    [self.mapView addGestureRecognizer:tap];

    
    [self.mapView setZoomLevel:16 animated:YES];
    [self.view addSubview:self.mapView];
    
    //定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self; //遵循代理<AMapLocationManagerDelegate>
    self.locationManager.distanceFilter = 200;
    [self.locationManager startUpdatingLocation];//开始定位
    
    //逆地理编码回调
    self.regeo = [[AMapReGeocodeSearchRequest alloc] init];
    self.searchPoi = [[AMapSearchAPI alloc] init];
    self.searchPoi.delegate = self; //遵循代理<AMapSearchDelegate>
    
    //设置地图中间的图片
    if (self.centerImgView == nil)
    {
        self.centerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(( *(_kScreenWidth) - 20)/2, (*(_kScreenHeight) - 37)/2, 20, 37)];
        self.centerImgView.image = [UIImage imageNamed:@"icon_location"];
    }
    [self.mapView addSubview:self.centerImgView];
    
    //设置button，显示当前定位的地址（也可以用Label，因为别的功能需要它的点击事件）
    self.poiButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, *(_kScreenWidth) - 40, 40)];
    self.poiButton.backgroundColor = [UIColor colorWithRed:248/255.0 green:252/255.0 blue:255/255.0 alpha:1];
    self.poiButton.layer.masksToBounds = YES;
    self.poiButton.layer.cornerRadius = 20.0;
    [self.poiButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.mapView addSubview:self.poiButton];
    
}

//允许多个交互事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    NSLog(@"当前经纬度：location:{lat:%f; lon:%f}", location.coordinate.latitude, location.coordinate.longitude);
    //将当前经纬度设置为地图的中心经纬度
    self.mapView.centerCoordinate = location.coordinate;
    
    //因为这个是后台持续定位的代理方法，所以必须停止定位，否则地图只要一移动就会回到当前所在位置。
    //因为一进入地图就会定位，延迟1s停止定位，是为了能够精准的获取到当前位置，否则可能会出现你定位在当前位置了，但是button上显示的却是别的地方的位置
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //执行事件
        [self.locationManager stopUpdatingLocation];//停止定位
    });
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
{
    self.centerCoor = [self.mapView convertPoint:self.mapView.center toCoordinateFromView:self.mapView];
    
    //开始逆地理编码，把当前经纬度转成中文地址
    self.regeo.location  = [AMapGeoPoint locationWithLatitude:self.centerCoor.latitude longitude:self.centerCoor.longitude];
    [self.searchPoi AMapReGoecodeSearch:self.regeo];
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        
        //解析response获取地址描述，可以自行选取需要的信息
        // self.nowStr 是由当前经纬度转化的中文地址
        self.nowStr = [NSString stringWithFormat:@"%@%@%@%@", response.regeocode.addressComponent.province, response.regeocode.addressComponent.city, response.regeocode.addressComponent.district, response.regeocode.addressComponent.streetNumber.street];
        ;
        NSLog(@"💖%@", self.nowStr);
        
        [self.poiButton setTitle:self.nowStr forState:(UIControlStateNormal)];
        
    }
}


- (void)tap:(UITapGestureRecognizer *)tap{
    NSLog(@"%@", self.nowStr);
    if([FullData shared].location != nil){
        [FullData shared].location = self.nowStr;
        [self.navigationController popViewControllerAnimated:YES];

    } else {
        [FullData shared].location = @"定位失敗";
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
