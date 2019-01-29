//
//  ViewController.h
//  30UITableViewStudentsHW
//
//  Created by Eduard Galchenko on 1/29/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGBStudent.h"

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

