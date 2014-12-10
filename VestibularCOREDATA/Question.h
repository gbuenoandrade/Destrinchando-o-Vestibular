//
//  Question.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Topic;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSString * resolution;
@property (nonatomic, retain) NSString * imagePosition;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSSet *topicsIBelong;
@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addTopicsIBelongObject:(Topic *)value;
- (void)removeTopicsIBelongObject:(Topic *)value;
- (void)addTopicsIBelong:(NSSet *)values;
- (void)removeTopicsIBelong:(NSSet *)values;

@end
