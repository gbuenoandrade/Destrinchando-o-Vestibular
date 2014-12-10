

//
//  TableRankingViewController.m
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import "TableRankingViewController.h"
#import "DatabaseCommunicator.h"
#import "Question+MetaInformation.h"
#import "Topic.h"
@interface TableRankingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTopMais;
@property (weak, nonatomic) IBOutlet UIImageView *imagemFundo;
@property (strong, nonatomic) NSArray* topicsOrdered;
@property (strong, nonatomic) NSDictionary* topics;
@property (nonatomic) NSInteger numberOfQuestions;

@property (weak, nonatomic) IBOutlet UILabel *labelNumberQuestao;

@end

@implementation TableRankingViewController

- (NSDictionary*)topics{
    if (!_topics) {
        NSMutableDictionary *topics = [NSMutableDictionary dictionary];
        NSArray *questions = [DatabaseCommunicator getQuestionsfromExam:self.selectedExam OfYears:self.arrayPeriodo phases:self.arrayFases ofSubject:self.materiaSelecionada inManagedObjectContext:self.managedObjectContext];
        self.numberOfQuestions = [questions count];
        for (Question *question in questions) {
            for (Topic* topic in question.topicsIBelong) {
                NSInteger incrementNumberOfQuestionsCoveredByTopic = [[[topics objectForKey:topic.name] objectForKey:@"numberOfIncidences"] integerValue] + 1;
                
                NSMutableArray* array;
                if ([[topics objectForKey:topic.name] objectForKey:@"topicsArray"] == nil) {
                    array = [NSMutableArray array];
                    [array addObject:topic];
                }
                else{
                    array = [[topics objectForKey:topic.name] objectForKey:@"topicsArray"];
                    [array addObject:topic];
                }
                
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:topic.name,@"name",[NSNumber numberWithInteger:incrementNumberOfQuestionsCoveredByTopic],@"numberOfIncidences",array,@"topicsArray",nil];
                [topics setValue:dict forKey:topic.name];
            }
        }
        return [NSDictionary dictionaryWithDictionary:topics];
    }
    return _topics;
}

- (NSArray*)topicsOrdered{
    if (!_topicsOrdered) {
        _topicsOrdered = [[self.topics allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger n1 = [[((NSDictionary*)obj1) objectForKey:@"numberOfIncidences"] integerValue];
            NSInteger n2 = [[((NSDictionary*)obj2) objectForKey:@"numberOfIncidences"] integerValue];
            if (n1 < n2) {
                return NSOrderedDescending;
            }
            else if (n1 > n2){
                return NSOrderedAscending ;
            }
            else{
                return NSOrderedSame;
            }
        }];
    }
    return _topicsOrdered;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    for(int i=0; i<[self.topics count]; ++i)
        NSLog(@"%@ - %d",[self.topicsOrdered[i] objectForKey:@"name"],[[self.topicsOrdered[i] objectForKey:@"numberOfIncidences"] integerValue]);
    
    
    //Label de numero de questoes nesse periodo escolhido
    self.labelNumberQuestao.text = [[NSString alloc] initWithFormat:@"(%d questões consideradas)", self.numberOfQuestions ];
    

    self.labelTopMais.font= [UIFont fontWithName:@"FromWhereYouAre" size:16];
self.labelNumberQuestao.font= [UIFont fontWithName:@"FromWhereYouAre" size:12];
    
    self.imagemFundo.image = [UIImage imageNamed:@"whiteBoard"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Voltar"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"YourTableCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        
        [[cell textLabel] setNumberOfLines:0]; // unlimited number of lines
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    
    double percentage = [[[self.topicsOrdered objectAtIndex:indexPath.row] objectForKey:@"numberOfIncidences"] doubleValue]*100 / self.numberOfQuestions;
    
    cell.textLabel.text = [[self.topicsOrdered objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1lf%%",percentage];

    cell.textLabel.font = [UIFont fontWithName:@"FromWhereYouAre" size:10];
    cell.detailTextLabel.font = [UIFont fontWithName:@"FromWhereYouAre" size:12];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [self performSegueWithIdentifier:@"questoesTela" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"questoesTela"]) {
        
        NSInteger row = ((NSIndexPath*)sender).row;
        QuestoesViewController *parQuestoesView = [segue destinationViewController];
        parQuestoesView.topicDict = [self.topicsOrdered objectAtIndex:row];
    }
}

@end
