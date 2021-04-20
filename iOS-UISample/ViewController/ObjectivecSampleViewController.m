//
//  ObjectivecSampleViewController.m
//  iOS-UISample
//
//  Created by nagisa miura on 2021/04/16.
//

#import "ObjectivecSampleViewController.h"
#import "iOS_UISample-swift.h"

@interface ObjectivecSampleViewController ()


@end

@implementation ObjectivecSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AgoraViewController *vc = [AgoraViewController new];
    [[self navigationController] pushViewController:vc animated: YES];
}

@end
