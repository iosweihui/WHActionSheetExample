//
//  WHActionSheetViewController.m
//  WHActionSheetExample
//
//  Created by quwan on 2017/6/19.
//  Copyright © 2017年 weihui. All rights reserved.
//

#import "WHActionSheetViewController.h"
#import "WHActionSheet.h"

@interface WHActionSheetViewController ()<WHActionSheetDelegate>

@end

@implementation WHActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, 100, 100, 50);
    [btn setTitle:@"ActionSheet" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(actionSheetAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheetAction{

    // 初始化 默认样式
    WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"默认样式" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"] cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetDefault) delegate:nil];
    
//     文字+图标样式 要为actionSheet的iconArr属性赋值
//    WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"图标+标题" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"] cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetIconAndTitle) delegate:nil];
    
    // 图标样式 要为actionSheet的iconArr属性赋值
//    WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"图标" sheetTitles:nil cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetIcon) delegate:nil];
    
    /*
     * 设置Sheet样式
     */
    actionSheet.isCorner = YES;
    actionSheet.titleColor = [UIColor greenColor];
    actionSheet.titleHeight = 100;
    actionSheet.titlebgColor = [UIColor yellowColor];
    actionSheet.subtitlebgColor = [UIColor cyanColor];
    actionSheet.subtitleColor = [UIColor blackColor];
    actionSheet.canclebgColor = [UIColor greenColor];
    actionSheet.cancleHeight = 80;
    
    // 传入图片数组
    UIImage *icon1 = [UIImage imageNamed:@"test01"];
    UIImage *icon2 = [UIImage imageNamed:@"test02"];
    UIImage *icon3 = [UIImage imageNamed:@"test03"];
    actionSheet.iconArr = [NSMutableArray arrayWithObjects:icon1,icon2,icon3, nil];
    
    /*
     * 设置代理 也可在初始化时设置代理
     */
    actionSheet.delegate = self;
    
    
    [actionSheet show];
    
}

/*
 * ActionSheet 代理方法
 */

- (void)actionSheet:(WHActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"点击了sheet%ld",(long)buttonIndex+1);
}

- (void)actionSheetCancle:(WHActionSheet *)actionSheet{

    NSLog(@"取消");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
