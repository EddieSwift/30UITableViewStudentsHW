//
//  ViewController.m
//  30UITableViewStudentsHW
//
//  Created by Eduard Galchenko on 1/29/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import "ViewController.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface ViewController ()

@property (assign, nonatomic) NSInteger amountOfStudents;
@property (strong, nonatomic) EGBStudent *student;
@property (strong, nonatomic) NSMutableArray *allStudents;
@property (strong, nonatomic) NSArray *sortedStudents;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.amountOfStudents = 30;
    self.allStudents = [NSMutableArray array];
    
    NSArray *allNames = [NSArray arrayWithObjects:@"Eric", @"Nick", @"John", @"Richi", @"Zakk", @"Paul", @"Steve", @"Gary", @"Bob", @"Hanry", nil];
    NSArray *allSurnames = [NSArray arrayWithObjects:@"Vai", @"Satriani", @"Gilbert", @"Moor", @"Wayld", @"Clapton", @"Hendrix", @"Blackmoor", @"Gilan", @"Milton", nil];
    
    for (int i = 0; i < self.amountOfStudents; i++) {
        
        self.student = [[EGBStudent alloc] init];
        NSInteger randomName = RAND_FROM_TO(0, 9);
        NSInteger randomSurname = RAND_FROM_TO(0, 9);
        NSInteger randomGrade = RAND_FROM_TO(2, 5);
        
        self.student.name = [allNames objectAtIndex:randomName];
        self.student.surname = [allSurnames objectAtIndex:randomSurname];
        self.student.averageGrade = randomGrade;
        
        [self.allStudents addObject:self.student];
    }
    
    // Sorting array using block
    self.sortedStudents = [self.allStudents sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        
        NSString *first = [(EGBStudent*)a name];
        NSString *second = [(EGBStudent*)b name];
        
        if ([first isEqualToString:second]) {
            
            NSString *first = [(EGBStudent*)a surname];
            NSString *second = [(EGBStudent*)b surname];
            
            return [first compare:second];
        }
        
        return [first compare:second];
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger section = 1;
    
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.amountOfStudents;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *listOfSudetns = @"listOfSudetns";
    
    return listOfSudetns;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath {%ld, %ld}", (long)indexPath.section, (long)indexPath.row);
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        NSLog(@"Cell created!");
        
    } else {
        
        NSLog(@"Cell reused!");
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [self.sortedStudents [indexPath.row] name], [self.sortedStudents [indexPath.row] surname]];
    
    if ([self.sortedStudents[indexPath.row] averageGrade] == 2) {
        
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Average grade at school: %ld",(long)[self.sortedStudents[indexPath.row] averageGrade]];

    return cell;
}


@end
