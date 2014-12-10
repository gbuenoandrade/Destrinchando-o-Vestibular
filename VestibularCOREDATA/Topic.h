//
//  Topic.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question, Subject;

@interface Topic : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *questionsWithin;
@property (nonatomic, retain) Subject *subjectIBelong;
@end

@interface Topic (CoreDataGeneratedAccessors)

- (void)addQuestionsWithinObject:(Question *)value;
- (void)removeQuestionsWithinObject:(Question *)value;
- (void)addQuestionsWithin:(NSSet *)values;
- (void)removeQuestionsWithin:(NSSet *)values;

@end
