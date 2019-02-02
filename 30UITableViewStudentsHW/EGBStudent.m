//
//  EGBStudent.m
//  30UITableViewStudentsHW
//
//  Created by Eduard Galchenko on 1/29/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import "EGBStudent.h"

@implementation EGBStudent

- (NSString *)description {
    
    return [NSString stringWithFormat: @"Student: Name: %@ Surname: %@ Grade: %ld", self.name, self.surname, (long)self.averageGrade];
}

@end
