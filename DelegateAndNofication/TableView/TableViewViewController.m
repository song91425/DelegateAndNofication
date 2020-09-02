//
//  TableViewViewController.m
//  DelegateAndNofication
//
//  Created by lssong on 2020/8/31.
//  Copyright © 2020 lssong. All rights reserved.
//

#import "TableViewViewController.h"
#import "CellDatas.h"
#import "FaceTableViewCell.h"
#import "NIBTableViewCell.h"
#import "OptionUICollectionViewController.h"
#define CELLID @"cell"


@interface TableViewViewController ()<UITableViewDelegate, UITableViewDataSource, SkipControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, assign) BOOL edit;

@end

@implementation TableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    self.imageView.image = [UIImage imageNamed:@"1"];
    NSLog(@"开始阶段");
    // Do any additional setup after loading the view.
}

-(NSArray *)datas{
    if (_datas == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"TableView.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        _datas = [NSMutableArray new];
        for (NSMutableArray *arr in array) {
            [_datas addObject:[CellDatas dataWithArray:arr]];
        }
        
    }
    return _datas;
}



// 初始化视图
-(void) initView{
    
    // 使用这个注册方式不会显示subtitle，原因是在复用CELLID的时候，cell的样式是默认的样式不会显示subtitle
    //    [self.tableView registerClass:[FaceTableViewCell class] forCellReuseIdentifier:CELLID];
    // 使用拖线方式，代理
    //    self.tableView.dataSource = self;
    //    self.tableView.delegate =self;
    
    //    self.tableView.separatorColor = [UIColor greenColor];
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"tableViewCell" bundle:nil] forCellReuseIdentifier:CELLID];
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 设置tableView的tableHeaderView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 65)];
    headerView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = headerView;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 30)];
    footerView.backgroundColor = [UIColor magentaColor];
    self.tableView.tableFooterView = footerView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr =self.datas[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 使用NIB来定义cellforView:(UITableView *) tableview
    
    NIBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    [cell setDatas:self.datas[indexPath.section][indexPath.item] forView: tableView];
    cell.view = self;
    
    // 使用代理来实现回调
    cell.delegate = self;
    // 使用block回调达到来响应按钮
    cell.btnClick=^{
           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[OptionUICollectionViewController new]];
           [self presentViewController:nav animated:YES completion:nil]; 
    };
    
    // 下面这条代码，可以放在cell类里
//    [cell.clickButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchDown];
    
    
//    FaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    if (!cell) {
//        cell = [[FaceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID] ;
//    }
//    cell.datas = self.datas[indexPath.section][indexPath.item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%@", indexPath);
}

// 设置编辑状态
- (IBAction)edit:(UIButton *)sender {
    _edit = _tableView.editing;
    if(_edit){
        [_tableView setEditing:NO animated:YES];
    }else{
        [_tableView setEditing:YES animated:YES];
    }
}

// 指定哪行可以编辑,如果是分组，这个路径是每个组的一第二条数据
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // 指定某个行可否编辑
    if (indexPath.row == 1) {
        return NO;
    }else{
        return YES;
    }
    
    // 指定某一个组可够编辑
    //    if (indexPath.section == 1) {
    //          return NO;
    //      }else{
    //          return YES;
    //      }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除操作");
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        NSLog(@"插入状态");
    }else{
        NSLog(@"默认无编辑状态");
    }
}



- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *collectAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"添加" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"添加了");
        CellDatas *cell = [CellDatas new];
        cell.title = @"新增的";
        cell.detail= @"干净利索呢哦女生";
        cell.icon = @"1";
        NSMutableArray *arr = self.datas[indexPath.section];
        
        [arr insertObject:cell atIndex:arr.count];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:arr.count-1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationRight];
        completionHandler(YES);
    }];
    //        collectAction.image = [UIImage imageNamed:@"delete"];
    collectAction.backgroundColor = [UIColor greenColor];
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"删除");
        // 先删除数据，再跟新视图
        NSLog(@"路径%@", indexPath);
        // 删除一个分组
        [self.datas removeObjectAtIndex:indexPath.section];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        
        // 删除某一行
//        [self.datas[indexPath.section] removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        //                [self.datas removeObjectAtIndex:indexPath.row];
        //                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        completionHandler(YES);
    }];
    
    
    //设置了图片，图片会被系统渲染成白色的
    deleteAction.image = [UIImage imageNamed:@"delete"];
    deleteAction.backgroundColor = [UIColor grayColor];
    
    UIContextualAction *moveToTop = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"顶置" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        // 顶置某一行到顶部
        CellDatas *data = self.datas[indexPath.section][indexPath.row];
        [self.datas[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.datas[indexPath.section] insertObject:data atIndex:0];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        completionHandler(YES);
    }];
    
    // 局部刷新
    UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"编辑然后刷新" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"刷新了");
        
        CellDatas *cell =  self.datas[indexPath.section][indexPath.row];
        cell.title = @"修改了";
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        completionHandler(YES);
    }];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[editAction,moveToTop,deleteAction,collectAction]];
}

// 使用代理完成跳转
- (void)skipToViewController:(NSInteger)tag{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[OptionUICollectionViewController new]];
    [self presentViewController:nav animated:YES completion:nil]; }

// 设置分组之间的第一条和上一个分组的距离
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

//给每组头部添加一个VIew
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
//    view.backgroundColor= [UIColor redColor];
//    return view;
//}


@end
