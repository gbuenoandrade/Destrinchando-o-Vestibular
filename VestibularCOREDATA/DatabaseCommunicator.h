//
//  DatabaseCommunicator.h
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/10/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseCommunicator : NSObject

+ (NSArray*)getQuestionsfromExam:(NSString*)exam OfYears:(NSArray*)years phases:(NSArray*)phases ofSubject:(NSString*)subject inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

+ (NSArray*)getTopicsfromExam:(NSString*)exam OfYears:(NSArray*)years phases:(NSArray*)phases ofSubject:(NSString*)subject inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

@end
