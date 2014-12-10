//
//  ImagemQuestaoViewController.m
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import "ImagemQuestaoViewController.h"
#import "Question+MetaInformation.h"
#import "Topic.h"

@interface ImagemQuestaoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelNomeQuestao; //Outelet para apresentar nome da questao
@property (weak, nonatomic) IBOutlet UITextView *topicos; //Quadro de texto para mostrar todos topicos de um array
@property (weak, nonatomic) IBOutlet UILabel *labelTabemPresente; //Label com mensagem do que se trata o "UITextView"mostrado
@property (weak, nonatomic) IBOutlet UIImageView *imagemFundo; //Imagem de fundo

@property (weak, nonatomic) IBOutlet UILabel *labelTituloResolucao;

@property (weak, nonatomic) IBOutlet UITextView *resolutionTextView;


@end

@implementation ImagemQuestaoViewController


- (IBAction)saveResolution:(id)sender {
    
    NSString* newResolution = self.resolutionTextView.text;
    self.question.resolution = newResolution;
    [self.view endEditing:YES];
    
    
//    NSError *error;
//    [self.question.managedObjectContext save:&error];
//    
//    if (error) {
//        NSLog(@"ERRO NA HORA DE SALVAR A RESOLUCAO: %@",[error description]);
//    }
//    else{
//        NSLog(@"A RESOLUCAO FOI SALVA COM SUCESSO!");
//    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.resolutionTextView.text = self.question.resolution;
    self.resolutionTextView.font = [UIFont fontWithName:@"FromWhereYouAre" size:12];
    

    //Seta topicos que tambem possui essa questao e coloca a fonte padrão
    self.topicos.text = [self alsoPresentString];
    self.topicos.font =[UIFont fontWithName:@"FromWhereYouAre" size:12];
    
 
    
    //Seta fonte da mensagem de "Tambem presente"e "Nome Questao".
    self.labelTabemPresente.font = [UIFont fontWithName:@"FromWhereYouAre" size:14];
    self.labelNomeQuestao.text = [[self.question getPrintableStringAndTopics]objectForKey:@"string"];
    
    self.labelNomeQuestao.font = [UIFont fontWithName:@"FromWhereYouAre" size:15];
    self.labelTituloResolucao.font = [UIFont fontWithName:@"FromWhereYouAre" size:15];
    //Seta imagem de fundo
    self.imagemFundo.image = [UIImage imageNamed:@"whiteBoard"];
    
}

- (NSString*)alsoPresentString{
    NSMutableString *tempString = [[NSMutableString alloc] init];
    
    for (Topic *topic in self.question.topicsIBelong) {
        if (![topic.name isEqualToString:self.currentTopic]) {
            [tempString appendString:[NSString stringWithFormat:@"%@\n",topic.name]];
        }
    }
    return [NSString stringWithString:tempString];
}


@end
