//
//  ViewController.m
//  ASDance
//
//  Created by toby on 21/06/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "ViewController.h"
#import "WeekCollectionViewCell.h"

static int course_days = 10;

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{

    UICollectionView *mainCollectionView;
    
}



@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)dealloc
{
    mainCollectionView = nil;
}
- (NSArray *)dataArray{
    if(!_dataArray){
       _dataArray = [self getAWeekDate];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake((self.view.frame.size.width)/7, (self.view.frame.size.width)/7);
    layout.minimumLineSpacing =0;
    layout.minimumInteritemSpacing = 0;
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
//    [mainCollectionView registerClass:[WeekCollectionViewCell class] forCellWithReuseIdentifier:@"WeekCollectionViewCell"];
    [mainCollectionView registerNib:[UINib nibWithNibName:@"WeekCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WeekCollectionViewCell"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return course_days;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeekCollectionViewCell *cell = (WeekCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WeekCollectionViewCell" forIndexPath:indexPath];
   
    if(indexPath.row == 0){
        cell.weekLab.text = self.dataArray[indexPath.section];
        cell.backgroundColor = [UIColor yellowColor];
    }
  
    
    return cell;
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//    headerView.backgroundColor =[UIColor grayColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//    label.text = @"这是collectionView的头部";
//    label.font = [UIFont systemFontOfSize:20];
//    [headerView addSubview:label];
//    return headerView;
//}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeekCollectionViewCell *cell = (WeekCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSString *msg = cell.botlabel.text;
//    NSLog(@"%@",msg);
    
    NSLog(@"item:%ld",(long)indexPath.row);
}


- (NSArray *)getAWeekDate{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];

    for(int i = 0;i<course_days;i++){
        // 获取当前时间
        NSDate *senddate = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]+60*60*24*i];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyy"];
        NSString *  yearString = [dateformatter stringFromDate:senddate];
        [dateformatter setDateFormat:@"MM"];
        NSString *  monthString = [dateformatter stringFromDate:senddate];
        [dateformatter setDateFormat:@"dd"];
        NSString *  dayString = [dateformatter stringFromDate:senddate];
        [dateformatter setDateFormat:@"EEE"];
        
//        NSString *  weekString = [dateformatter stringFromDate:senddate];
//        NSLog(@"-%@",weekString);
        int year = [yearString intValue];
//        NSLog(@"-%d", year);
        int month = [monthString intValue];
//        NSLog(@"--%d", month);
        int day = [dayString intValue];
//        NSLog(@"---%d", day);
      
        [array addObject:[NSString stringWithFormat:@"%d/%d \n%@",month,day,(i==0?@"今天":[self getWeekDayFordate:senddate])]];

    }
    
    
    
    return array;
}

//根据时间戳获取星期几
- (NSString *)getWeekDayFordate:(NSDate *)date
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *newDate = date;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
