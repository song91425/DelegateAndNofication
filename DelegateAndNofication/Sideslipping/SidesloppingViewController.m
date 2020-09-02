//
//  SidesloppingViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/28.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "SidesloppingViewController.h"
#import "SWRevealViewController.h"
#import "OptionUICollectionViewController.h"
#import "WaterLayoutViewController.h"
#import "TableBarViewController.h"
//#import "<#header#>"

@interface SidesloppingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *menuArray;

@end

@implementation SidesloppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void) initView{
    self.view.backgroundColor = [UIColor redColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height -20) style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
}

-(void) initData{
    _menuArray = [NSArray arrayWithObjects:@"无线轮播",@"瀑布流",@"底部导航栏", @"留用",nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *TABLE_VIEW_ID = @"table_view_id";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_VIEW_ID];
    
    static NSString *CELLID = @"cell";
    UITableViewCell *tabelCell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!tabelCell) {
        tabelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    tabelCell.textLabel.text = [_menuArray objectAtIndex:indexPath.row];
    return tabelCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealViewController = self.revealViewController;
    UIViewController *viewController;
    UIStoryboard *story;
    switch (indexPath.row) {
        case 0:
            viewController = [OptionUICollectionViewController new];
            break;
        case 1:
            viewController = [WaterLayoutViewController new];
            break;
        case 2:
            story = [UIStoryboard storyboardWithName:@"TableBar" bundle:nil];
            viewController = [story instantiateViewControllerWithIdentifier:@"TableBarViewController"];
            // ios 13 后需要指定启动模式
               viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            break;
        case 3:
            break;
        default:
            break;
    }
    
    [revealViewController pushFrontViewController:viewController animated:YES];
    
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
