//
//  Exam.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test;

@interface Exam : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tests;
@end

@interface Exam (CoreDataGeneratedAccessors)

- (void)addTestsObject:(Test *)value;
- (void)removeTestsObject:(Test *)value;
- (void)addTests:(NSSet *)values;
- (void)removeTests:(NSSet *)values;

@end
