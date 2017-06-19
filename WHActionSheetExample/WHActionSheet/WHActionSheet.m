//
//  WHActionSheetView.m
//  BeeBee
//
//  Created by quwan on 2017/6/15.
//  Copyright © 2017年 quwan. All rights reserved.
//

// 默认设置
#define SHOWTIME 0.3 //显示时间
#define DISSMISSTIME 0.3 //消失时间
#define CORNER 15 //圆角大小
#define SHEETHEIGHT 50
#define CANCLEHEIGHT 50
#define TITLEHEIGHT 60
#define SECTIONHEIGHT 5
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#import "WHActionSheet.h"

@interface WHActionSheet()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *sheetTable;
@property (nonatomic,assign) WHActionSheetStyle actionsheetStyle;
@end

@implementation WHActionSheet
{
    NSString *_sheetTitle;
    NSString *_cancleTitle;
    NSArray *_sheetTitleArr;
    UIView *_headerView;
    UILabel *_titleLabel;
    UIButton *_cancleBtn;
    
    CGFloat _tableHeight;
    CGFloat _cellHeight;
    CGFloat _titleHeight;
    CGFloat _cancleHeight;
    NSInteger _cellCount;
}

- (instancetype)initWithTitle:(NSString *)title
                  sheetTitles:(NSArray *)sheetTitles
               cancleBtnTitle:(NSString *)cancleBtnTitle
                   sheetStyle:(WHActionSheetStyle)sheetStyle
                     delegate:(id<WHActionSheetDelegate>)delegate{
    
    if (self = [super init]) {
     
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        _actionsheetStyle = sheetStyle;
        _sheetTitle = title;
        _cancleTitle = cancleBtnTitle;
        _sheetTitleArr = sheetTitles;
        _cellCount = _sheetTitleArr.count;
        if (delegate) {
            self.delegate = delegate;
        }
    }
    return self;
}

- (void)setupView{
    
    if (_cellCount == 0) {
        _cellCount = _iconArr.count;
    }
    [UIView animateWithDuration:SHOWTIME animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    _cellHeight = (_sheetHeight)?_sheetHeight:SHEETHEIGHT;
    _titleHeight = (_titleHeight)?_titleHeight:TITLEHEIGHT;
    _cancleHeight = (_cancleHeight)?_cancleHeight:CANCLEHEIGHT;
    _tableHeight = (_sheetTitle.length == 0)?(_cellCount*_cellHeight + _cancleHeight + SECTIONHEIGHT):((_cellCount)*_cellHeight + _titleHeight + _cancleHeight + SECTIONHEIGHT*2);
    
    if (_sheetTitle.length != 0) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleHeight)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = _sheetTitle;
        [_headerView addSubview:_titleLabel];
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _cancleHeight)];
    _cancleBtn = [[UIButton alloc] init];
    _cancleBtn.frame = CGRectMake(0, 0, ScreenWidth, _cancleHeight);
    [_cancleBtn setTitle:_cancleTitle forState:(UIControlStateNormal)];
    [_cancleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _cancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancleBtn addTarget:self action:@selector(actionSheetCancle:) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:_cancleBtn];
    
    self.sheetTable = [[UITableView alloc] init];
    _sheetTable.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _tableHeight);
    _sheetTable.backgroundColor = [UIColor clearColor];
    _sheetTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sheetTable.delegate = self;
    _sheetTable.dataSource = self;
    _sheetTable.scrollEnabled = NO;
    _sheetTable.tableHeaderView = _headerView;
    _sheetTable.tableFooterView = footerView;
    [self addSubview:_sheetTable];
}

- (void)show{

    [self setupView]; //创建视图
    [self setSheetProperty]; //设置自定义属性
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:SHOWTIME animations:^{
        self.sheetTable.frame = CGRectMake(0, ScreenHeight - _tableHeight, ScreenWidth, _tableHeight);
    }];
}

- (void)setSheetProperty{

    if (self.titleColor) {
        _titleLabel.textColor = self.titleColor;
    }
    if (self.titleFont) {
        _titleLabel.font = self.titleFont;
    }
    if (self.titlebgColor) {
        _titleLabel.backgroundColor = self.titlebgColor;
    }
    if (self.canclebgColor) {
        [_cancleBtn setBackgroundColor:self.canclebgColor];
    }
    if (self.isCorner) {
        _titleLabel.layer.cornerRadius = CORNER;
        _titleLabel.layer.masksToBounds = YES;
        _cancleBtn.layer.cornerRadius = CORNER;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"sheetCell";
    WHActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WHActionSheetCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    if (_actionsheetStyle == WHActionSheetDefault) {
        [cell setupWHActionSheetDefaultCellWithTitle:_sheetTitleArr[indexPath.row] CellHeight:_cellHeight];
    }else if (_actionsheetStyle == WHActionSheetIconAndTitle){
        UIFont *font = _subtitleFont?_subtitleFont:[UIFont systemFontOfSize:17];
        [cell setupWHActionSheetIconAndTitleWithTitle:_sheetTitleArr[indexPath.row] titleFont:font icon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }else if (_actionsheetStyle == WHActionSheetIcon){
        [cell setupWHActionSheetIconAndTitleWithIcon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }
    
    if (self.subtitleColor) {
        cell.titleLab.textColor = self.subtitleColor;
    }
    if (self.subtitleFont) {
        cell.titleLab.font = self.subtitleFont;
    }
    if (self.subtitlebgColor) {
        cell.coverView.backgroundColor = self.subtitlebgColor;
    }
    if (self.lineColor) {
        cell.bottomLine.backgroundColor = self.lineColor;
    }
    if (self.isCorner) {
        UIBezierPath *maskPath;
        if (indexPath.row == 0) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.coverView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CORNER, CORNER)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }else if (indexPath.row == _cellCount-1){
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.coverView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CORNER, CORNER)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }
        
    }
    if (indexPath.row == _cellCount-1) {
        cell.bottomLine.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_sheetTitle.length != 0) {
        return SECTIONHEIGHT;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SECTIONHEIGHT)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SECTIONHEIGHT)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return SECTIONHEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self actionSheet:self clickButtonAtIndex:indexPath.row];
}

#pragma mark WHActionSheetDelegate
- (void)actionSheet:(WHActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickButtonAtIndex:buttonIndex];
    }
    [self dissmiss];
    
}

- (void)actionSheetCancle:(WHActionSheet *)actionSheet{

    if ([self.delegate respondsToSelector:@selector(actionSheetCancle:)]) {
        [self.delegate actionSheetCancle:self];
    }
    [self dissmiss];
}

#pragma mark dissmiss
- (void)dissmiss{

    [UIView animateWithDuration:DISSMISSTIME animations:^{
        self.alpha = 0;
        self.sheetTable.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _tableHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 点击阴影部分是让视图消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] != _sheetTable) {
        [self dissmiss];
    }
}


@end
