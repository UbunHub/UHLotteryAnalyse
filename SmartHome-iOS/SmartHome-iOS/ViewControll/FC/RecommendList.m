//
//  RecommendList.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/19.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "RecommendList.h"
#import "RecommendInfoVC.h"

@interface RecommendList ()
@property(strong, nonatomic)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *dataDableView;
@end

@implementation RecommendList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"5",@"10",@"20",@"50", nil];
    [_dataDableView reloadData];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSString *str = [_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%@期统计",str];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendInfoVC*recommendInfoVC = [[RecommendInfoVC alloc]init];
    [self.navigationController pushViewController:recommendInfoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
