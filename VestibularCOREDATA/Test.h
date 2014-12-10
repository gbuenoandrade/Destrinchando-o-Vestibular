//
//  Test.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exam, Subject;

@interface Test : NSManagedObject

@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * phase;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Exam *examIBelong;
@property (nonatomic, retain) NSSet *subjects;
@end

@interface Test (CoreDataGeneratedAccessors)

- (void)addSubjectsObject:(Subject *)value;
- (void)removeSubjectsObject:(Subject *)value;
- (void)addSubjects:(NSSet *)values;
- (void)removeSubjects:(NSSet *)values;

@end
