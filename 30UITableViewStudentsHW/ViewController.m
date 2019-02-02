//
//  ViewController.m
//  30UITableViewStudentsHW
//
//  Created by Eduard Galchenko on 1/29/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import "ViewController.h"
#import "EGBColorRow.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))
static const NSInteger amountOfStudents = 30;

@interface ViewController ()

@property (strong, nonatomic) EGBStudent *student;
@property (strong, nonatomic) NSMutableArray *allStudents;
@property (strong, nonatomic) NSArray *sortedStudents;

@property (strong, nonatomic) NSMutableArray *excellentStudents;
@property (strong, nonatomic) NSMutableArray *goodStudents;
@property (strong, nonatomic) NSMutableArray *losersStudents;

@property (strong, nonatomic) NSMutableArray *superArray;
@property (strong, nonatomic) NSArray *typeOfStudents;
@property (assign, nonatomic) NSInteger numberOfRowsInSection;

@property (assign, nonatomic) CGFloat red;
@property (assign, nonatomic) CGFloat green;
@property (assign, nonatomic) CGFloat blue;
@property (strong, nonatomic) NSString *rgbColorData;
@property (strong, nonatomic) NSMutableArray *arrayOfColoredRows;
@property (strong, nonatomic) EGBColorRow *colorRow;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.allStudents = [NSMutableArray array];
    
    self.excellentStudents = [NSMutableArray array];
    self.goodStudents = [NSMutableArray array];
    self.losersStudents = [NSMutableArray array];
    
    self.typeOfStudents = [[NSArray alloc] initWithObjects:@"Excellent Students", @"Good Students", @"Loser Students", @"Colored Rows", nil];
    
    [self creatingListOfStudents];
    
    [self sortingArray];
    
    self.arrayOfColoredRows = [NSMutableArray array];
    
    [self creatingColoredRows];
    
    self.superArray = [NSMutableArray arrayWithObjects:self.excellentStudents, self.goodStudents, self.losersStudents, self.arrayOfColoredRows, nil];
}

#pragma mark - Private methods

- (void) creatingListOfStudents {
    
    NSArray *allNames = [NSArray arrayWithObjects:@"Eric", @"Nick", @"John", @"Richi", @"Zakk", @"Paul", @"Steve", @"Gary", @"Bob", @"Hanry", nil];
    NSArray *allSurnames = [NSArray arrayWithObjects:@"Vai", @"Satriani", @"Gilbert", @"Moor", @"Wayld", @"Clapton", @"Hendrix", @"Blackmoor", @"Gilan", @"Milton", nil];
    
    for (int i = 0; i < amountOfStudents; i++) {
        
        self.student = [[EGBStudent alloc] init];
        NSInteger randomName = RAND_FROM_TO(0, 9);
        NSInteger randomSurname = RAND_FROM_TO(0, 9);
        NSInteger randomGrade = RAND_FROM_TO(2, 5);
        
        self.student.name = [allNames objectAtIndex:randomName];
        self.student.surname = [allSurnames objectAtIndex:randomSurname];
        self.student.averageGrade = randomGrade;
        
        [self.allStudents addObject:self.student];
    }
}

 // Sorting array using block
- (void) sortingArray {
    
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
   
    // Sorting students to different sections of Table View
    for (EGBStudent *student in self.sortedStudents) {
        
        if (student.averageGrade == 5) {
            
            [self.excellentStudents addObject:student];
            
        } else if (student.averageGrade == 4 || student.averageGrade == 3) {
            
            [self.goodStudents addObject:student];
            
        } else if (student.averageGrade == 2) {
            
            [self.losersStudents addObject:student];
        }
    }
}

- (void) creatingColoredRows {
    
    for (int i = 0; i < 10; i++) {
        
        self.colorRow = [[EGBColorRow alloc] init];
        
        self.colorRow.color = [self randomColor];
        self.colorRow.name = [NSString stringWithFormat:@"RGB(%1.0f, %1.0f, %1.0f)", self.red, self.green, self.blue];
        
        [self.arrayOfColoredRows addObject:self.colorRow];
    }
}

- (UIColor*) randomColor {
    
    NSLog(@"New color for cell created!");
    
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    
    self.red = (CGFloat)(r * 255.f);
    self.green = (CGFloat)(g * 255.f);
    self.blue = (CGFloat)(b * 255.f);
    
    NSLog(@"RGB(%f, %f, %f)", r, g, b);
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.superArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return [self.typeOfStudents objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.superArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath {%ld, %ld}", (long)indexPath.section, (long)indexPath.row);
    
    if (indexPath.section != 3) {
        
        static NSString *identifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            NSLog(@"Cell created!");
        } else {
            
            NSLog(@"Cell reused!");
        }
        
        self.student = [[self.superArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if (indexPath.section == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.name, self.student.surname];
            
            cell.textLabel.textColor = [UIColor greenColor];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Average grade at school: %ld",self.student.averageGrade];
        }
        
        if (indexPath.section == 1) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.name, self.student.surname];
            
            cell.textLabel.textColor = [UIColor orangeColor];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Average grade at school: %ld",self.student.averageGrade];
        }
        
        if (indexPath.section == 2) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.name, self.student.surname];
            
            cell.textLabel.textColor = [UIColor redColor];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Average grade at school: %ld",self.student.averageGrade];
        }
        
        return cell;
        
    } else {
        
        static NSString *defaultIdentifier = @"Default Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultIdentifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultIdentifier];
            NSLog(@"Cell created!");
            
        } else {
            
            NSLog(@"Cell reused!");
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.arrayOfColoredRows[indexPath.row] name]];
        cell.backgroundColor = (__bridge UIColor * _Nullable)([self.arrayOfColoredRows[indexPath.row] color]);
        
        return cell;
    }
}

@end
