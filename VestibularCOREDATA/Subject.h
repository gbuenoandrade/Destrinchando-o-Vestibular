//
//  Subject.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test, Topic;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Test *testIBelong;
@property (nonatomic, retain) NSSet *topics;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addTopicsObject:(Topic *)value;
- (void)removeTopicsObject:(Topic *)value;
- (void)addTopics:(NSSet *)values;
- (void)removeTopics:(NSSet *)values;

@end
