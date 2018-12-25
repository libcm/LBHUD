//
//  ViewController.m
//  LBHUDDemo
//
//  Created by lib on 2018/11/17.
//  Copyright © 2018年 lib. All rights reserved.
//

#import "ViewController.h"
#import "LBHUD.h"
#import "ViewController2.h"

@interface ViewController ()<UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController2 *vc = segue.destinationViewController;
    vc.identifier = segue.identifier;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section) {
        if (indexPath.row == 0) {
            [LBHUD showWithView:self.view message:@"默认状态,显示2秒"];
        }else if (indexPath.row == 1) {
            [[LBHUD showWithMessage:@"带属性提示语,显示2秒"] setMessageAttributes:@{NSForegroundColorAttributeName: [UIColor cyanColor], NSFontAttributeName: [UIFont systemFontOfSize:20]}];
        }else if (indexPath.row == 2) {
            [[LBHUD showWithMessage:@"提示语背景色,默认RGBA(239,239,244,0.99),显示2秒"] setMessageBackgroundColor:[UIColor cyanColor]];
        }else {
            [[LBHUD showWithMessage:@"提示语背景圆角,默认10,显示2秒"] setMessageBackgroundRadius:5];
        }
    }
}

@end
