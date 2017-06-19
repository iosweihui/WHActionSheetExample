# WHActionSheetExample
自定义ActionSheet,可设置多种样式

    /*
     * 初始化 默认样式
     */
    WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"默认样式" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"] cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetDefault) delegate:nil];
    
    /*
     * 文字+图标样式 要为actionSheet的iconArr属性赋值
     */
    /*
         WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"图标+标题" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"] cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetIconAndTitle) delegate:nil];
     */

    /*
     * 图标样式 要为actionSheet的iconArr属性赋值
     */
    /*
         WHActionSheet *actionSheet = [[WHActionSheet alloc] initWithTitle:@"图标" sheetTitles:nil cancleBtnTitle:@"取消" sheetStyle:(WHActionSheetIcon) delegate:nil];
     */
    
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
    
    /*
     *传入图片数组
     */
    UIImage *icon1 = [UIImage imageNamed:@"test01"];
    UIImage *icon2 = [UIImage imageNamed:@"test02"];
    UIImage *icon3 = [UIImage imageNamed:@"test03"];
    actionSheet.iconArr = [NSMutableArray arrayWithObjects:icon1,icon2,icon3, nil];
    
    /*
     * 设置代理 也可在初始化时设置代理
     */
    actionSheet.delegate = self;
    
    [actionSheet show];
