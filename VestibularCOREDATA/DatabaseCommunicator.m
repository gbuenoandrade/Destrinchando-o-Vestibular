//
//  DatabaseCommunicator.m
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/10/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import "DatabaseCommunicator.h"
#import "Test.h"
#import "Question.h"
#import "Subject.h"
#import "Topic.h"

#import "Question+MetaInformation.h"

@implementation DatabaseCommunicator

+ (NSArray*)getQuestionsfromExam:(NSString*)exam OfYears:(NSArray*)years phases:(NSArray*)phases ofSubject:(NSString*)subject inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Test"];
    //    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
    //                                                              ascending:YES
    //                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSMutableArray *phasesPreds = [[NSMutableArray alloc] init];
    for (NSNumber *phaseNum in phases) {
        [phasesPreds addObject:[NSPredicate predicateWithFormat:@"phase == %d",[phaseNum integerValue]]];
    }
    NSPredicate *compoundPhasesPred = [NSCompoundPredicate orPredicateWithSubpredicates:phasesPreds];

    
    
    
    NSMutableArray *yearsPreds = [[NSMutableArray alloc] init];
    for (NSNumber *yearNum in years) {
        [yearsPreds addObject:[NSPredicate predicateWithFormat:@"year == %d",[yearNum integerValue]]];
    }
    NSPredicate *compoundYearsPred = [NSCompoundPredicate orPredicateWithSubpredicates:yearsPreds];
    
    
    
        
    NSPredicate *examSubPred = [NSPredicate predicateWithFormat:@"(examIBelong.name = %@) && (subjects.name CONTAINS %@)",exam,subject];


    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:compoundPhasesPred,compoundYearsPred,examSubPred,nil]];
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERRO NA QUERY: %@",[error description]);
        return nil;
    }
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (Test *tst in results) {
        for (Subject *sbj in tst.subjects) {    //TODO como fazer essa comparacao ja no predicado
            if ([sbj.name isEqualToString:subject])
                for (Topic* tpc in sbj.topics) {
                    for (Question *qst in tpc.questionsWithin) {
                        [set addObject:qst];
                    }
            }
        }
    }
    
    return [set allObjects];
}

+ (NSArray*)getTopicsfromExam:(NSString*)exam OfYears:(NSArray*)years phases:(NSArray*)phases ofSubject:(NSString*)subject inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Test"];
    //    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
    //                                                              ascending:YES
    //                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSMutableArray *phasesPreds = [[NSMutableArray alloc] init];
    for (NSNumber *phaseNum in phases) {
        [phasesPreds addObject:[NSPredicate predicateWithFormat:@"phase == %d",[phaseNum integerValue]]];
    }
    NSPredicate *compoundPhasesPred = [NSCompoundPredicate orPredicateWithSubpredicates:phasesPreds];
    
    
    
    
    NSMutableArray *yearsPreds = [[NSMutableArray alloc] init];
    for (NSNumber *yearNum in years) {
        [yearsPreds addObject:[NSPredicate predicateWithFormat:@"year == %d",[yearNum integerValue]]];
    }
    NSPredicate *compoundYearsPred = [NSCompoundPredicate orPredicateWithSubpredicates:yearsPreds];
    
    
    
    
    NSPredicate *examSubPred = [NSPredicate predicateWithFormat:@"(examIBelong.name == %@)",exam];
    
    //  NSPredicate *examSubPred = [NSPredicate predicateWithFormat:@"ANY subjects.name LIKE %@",subject];
    
    //NSPredicate *examSubPred = [NSPredicate predicateWithFormat:@"ANY subjects.name == %@",subject];
    
    
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:compoundPhasesPred,compoundYearsPred,examSubPred,nil]];
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERRO NA QUERY: %@",[error description]);
        return nil;
    }
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (Test *tst in results) {
        for (Subject *sbj in tst.subjects) {    //TODO como fazer essa comparacao ja no predicado
            if ([sbj.name isEqualToString:subject])
                for (Topic* tpc in sbj.topics) {
                    [set addObject:tpc];
                }
        }
    }
    
    return [set allObjects];
}

@end
