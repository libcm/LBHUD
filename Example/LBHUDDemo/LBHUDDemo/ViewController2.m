//
//  ViewController2.m
//  LBHUDDemo
//
//  Created by lib on 2018/11/17.
//  Copyright © 2018年 lib. All rights reserved.
//

#import "ViewController2.h"
#import "LBHUD.h"

@interface ViewController2 ()<UITableViewDelegate>
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIdentifier:(NSString *)identifier {
    _identifier = identifier;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if ([self.identifier isEqualToString:@"show"]) {
            [LBHUD show];
        }else if ([self.identifier isEqualToString:@"delay"]) {
            [LBHUD showWithAfterDelay:2];
        }else {
            [LBHUD showWithAfterDelay:2 complete:^{
                [LBHUD showWithMessage:@"展示完成"];
            }];
        }
    }else if (indexPath.row == 1) {
        if ([self.identifier isEqualToString:@"show"]) {
            [[LBHUD show] setTintColor:[UIColor cyanColor]];
        }else if ([self.identifier isEqualToString:@"delay"]) {
            [[LBHUD showWithAfterDelay:2] setTintColor:[UIColor cyanColor]];
        }else {
            [[LBHUD showWithAfterDelay:2 complete:^{
                [LBHUD showWithMessage:@"展示完成"];
            }] setTintColor:[UIColor cyanColor]];
        }
    }else {
        if ([self.identifier isEqualToString:@"show"]) {
            [[LBHUD show] setBackgroundColor:[UIColor cyanColor]];
        }else if ([self.identifier isEqualToString:@"delay"]) {
            [[LBHUD showWithAfterDelay:2] setBackgroundColor:[UIColor cyanColor]];
        }else {
            [[LBHUD showWithAfterDelay:2 complete:^{
                [LBHUD showWithMessage:@"展示完成"];
            }] setBackgroundColor:[UIColor cyanColor]];
        }
    }
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
