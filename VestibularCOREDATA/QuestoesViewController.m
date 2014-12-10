//
//  QuestoesViewController.m
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import "QuestoesViewController.h"
#import "Topic.h"
#import "Question+MetaInformation.h"

@interface QuestoesViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imagemFundo; //Imagem de fundo da tela
@property (strong, nonatomic) NSArray* questions;

@end



@implementation QuestoesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagemFundo.image = [UIImage imageNamed:@"whiteBoard"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Voltar"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];
    
}

- (NSArray*)questions{
    if (!_questions) {
        NSArray* topics = [self.topicDict objectForKey:@"topicsArray"];
        NSMutableSet *questionsAux = [NSMutableSet set];
        for (Topic* topic in topics) {
            for (Question* question in topic.questionsWithin) {
                [questionsAux addObject:question];
            }
            
        }
        _questions = [questionsAux allObjects];
    }
    return _questions;
}

//Metodo de delegate dessa classe que controla a table. Devolve o numero de dados na tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.topicDict objectForKey:@"numberOfIncidences"] integerValue];
}

//Metodo de delegate dessa classe que controla a table. Cria uma celula para a tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"YourTableCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        
        [[cell textLabel] setNumberOfLines:0]; // Nao limitado numero de linhas
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    //Captura questao para mostra na celula da tableView
    
    NSString *linhaImprimir = [[[self.questions objectAtIndex:indexPath.row] getPrintableStringAndTopics] objectForKey:@"string"];
    
    //Seta celula com informaçao da questao
    cell.textLabel.text = linhaImprimir;
    cell.textLabel.font = [UIFont fontWithName:@"FromWhereYouAre" size:12];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Chama metodo para transicionar para outra tela
    [self performSegueWithIdentifier:@"imagemTela" sender:indexPath];
}

/* Metodo responsável por prepara os dados para ImagemQuestaoViewControler. Ele passa
 * qual foi o topico clicado por referencia.*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"imagemTela"]) {
        
        ImagemQuestaoViewController *parImagemView = [segue destinationViewController];
        NSInteger row = ((NSIndexPath*)sender).row;
        parImagemView.question = [self.questions objectAtIndex:row];
        parImagemView.currentTopic = [self.topicDict objectForKey:@"name"];
    }
}

@end


