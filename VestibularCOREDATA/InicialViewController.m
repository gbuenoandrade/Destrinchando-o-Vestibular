//
//  InicialViewController.m
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import "InicialViewController.h"
#import "ParametrosViewController.h"
#import "Test.h"
#import "Question.h"
#import "Subject.h"
#import "Topic.h"
#import "DatabaseCommunicator.h"

@interface InicialViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelFonte;
@property (weak, nonatomic) IBOutlet UIImageView *imagemFundo;
@property (weak, nonatomic) IBOutlet UIButton *labelButRank;
@property (weak, nonatomic) IBOutlet UIButton *labelButProva;
@property (weak, nonatomic) IBOutlet UIButton *labelButTopico;

@end

@implementation InicialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //seta plano e detalhes das fontes na tela
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    self.itemsArray = [[NSArray alloc] initWithObjects:@"Fuvest",@"Unicamp",@"ITA",@"IME",nil];
    self.imagemFundo.image = [UIImage imageNamed:@"whiteBoard"];
    self.labelFonte.font = [UIFont fontWithName:@"FromWhereYouAre" size:20];
    self.labelButProva.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelButRank.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelButTopico.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Voltar"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
    
    
    if (self.managedObjectContext) {
        
    //    NSArray *questions = [DatabaseCommunicator getQuestionsfromExam:@"Fuvest" OfYears:@[@2013] phases:@[@1,@2] ofSubject:@"Matemática" inManagedObjectContext:self.managedObjectContext];
        
    //    NSLog(@"achei %d questions, nao necessariamente distintas!",[questions count]);
    }
    
    
    
}


//- (void)countQuestionInBD{
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Test"];
//    //    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
//    //                                                              ascending:YES
//    //                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
//    
//    
//    //request.predicate = [NSPredicate predicateWithFormat:@"phase == %@ && day == %@",@2,@3];
//    
//    
//    NSError *error;
//    
//    
//    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (!results || error) {
//        NSLog(@"bugou a query: %@",[error description]);
//    }
//    else{
//        [self.managedObjectContext save:&error];
//        if (error) {
//            NSLog(@"deu erro na hora de salvar o BD %@",[error description]);
//        }
//        
//        int questionCount = 0;
//        NSMutableSet *questionsFound = [[NSMutableSet alloc] init];
//        
//        for (Test *tst in results) {
//            for (Subject *sjb in tst.subjects) {
//                for (Topic *tpc in sjb.topics) {
//                    for (Question *qst in tpc.questionsWithin) {
//                        ++questionCount;
//                        [questionsFound addObject:qst];
//                    }
//                }
//            }
//        }
//        
//        
//        
//        NSLog(@"ae, seu doido, tem %d tests no BD e %d questions!",[results count],[questionsFound count]);
//        
//        for (Question *qst in questionsFound) {
//            NSLog(@"%@\n",qst.resolution);
//        }
//    }
//}
//


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"parametrosTela"]) {
        ParametrosViewController *parView = [segue destinationViewController];
        parView.selectedExam = [self.itemsArray objectAtIndex:[self.myPickerView selectedRowInComponent:0]];
        parView.managedObjectContext = self.managedObjectContext;
    }
}

//inicio das configuracoes do pickerView

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.itemsArray count];
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

/*- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.itemsArray objectAtIndex:row];
}
*/
//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // nao faca nada por enquanto, mais vestibulares em breve
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        //label size
        CGRect frame = CGRectMake(0.0, 0.0, 130, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        //here you can play with fonts
        [pickerLabel setFont:[UIFont fontWithName:@"FromWhereYouAre" size:18.0]];
    }
    //picker view array is the datasource
    [pickerLabel setText:[self.itemsArray objectAtIndex:row]];
    return pickerLabel;
}

//fim das configuracoes do pickerView




@end


