//
//  ParametrosViewController.m
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import "ParametrosViewController.h"
#import "TableRankingViewController.h"

@interface ParametrosViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelFonte1Fase;
@property (weak, nonatomic) IBOutlet UILabel *labelFonte2Fase;
@property (weak, nonatomic) IBOutlet UILabel *labelDe;

@property (weak, nonatomic) IBOutlet UIButton *labelBotao;
@property (weak, nonatomic) IBOutlet UILabel *labelAte;
@property (weak, nonatomic) IBOutlet UISwitch *switch2Fase;
@property (weak, nonatomic) IBOutlet UISwitch *switch1Fase;
@property (weak, nonatomic) IBOutlet UIPickerView *materiasPickerView;
@property (weak, nonatomic) IBOutlet UISlider *sliderAnoMinimoConsiderado;
@property (weak, nonatomic) IBOutlet UISlider *sliderAnoMaximoConsiderado;
@property(strong,nonatomic) NSArray* pickerArray;
@property (strong, nonatomic) NSString* materiaSelecionada;
@property (nonatomic) int anoMinimoConsiderado;
@property (nonatomic) int anoMaximoConsiderado;
@property (weak, nonatomic) IBOutlet UILabel *labelAnoMinimoConsiderado;
@property (weak, nonatomic) IBOutlet UILabel *labelAnoMaximoConsiderado;
- (NSMutableArray*)geraVetorFases;
- (NSMutableArray*)geraVetorIntervalo;

@end

@implementation ParametrosViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //iniciando pickerView
    self.materiasPickerView.delegate = self;
    self.materiasPickerView.dataSource = self;
    self.pickerArray = [[NSArray alloc] initWithObjects: @"Física",@"Matemática",@"Biologia",  @"Geografia", @"História", @"Inglês", @"Português", @"Química", @"Biologia",nil];
    self.sliderAnoMinimoConsiderado.minimumValue=2004;
    self.sliderAnoMinimoConsiderado.maximumValue=2013;
    self.sliderAnoMaximoConsiderado.minimumValue=2004;
    self.sliderAnoMaximoConsiderado.maximumValue=2013;
    self.sliderAnoMinimoConsiderado.value = 2004;
    self.sliderAnoMaximoConsiderado.value = 2013;
    self.anoMinimoConsiderado = 2004;
    self.anoMaximoConsiderado = 2013;
    self.materiaSelecionada = [NSString stringWithFormat:@"Física"];
    
    //configurando plano funto e fontes
    self.labelAte.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelDe.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelFonte1Fase.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelFonte2Fase.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelAnoMinimoConsiderado.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.labelAnoMaximoConsiderado.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    self.imageBackground.image = [UIImage imageNamed:@"whiteBoard"];
    self.labelBotao.font = [UIFont fontWithName:@"FromWhereYouAre" size:16];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Voltar"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButton];

   
}

//inicio configuracoes pickerView

#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerArray count];
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
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
        [pickerLabel setFont:[UIFont fontWithName:@"FromWhereYouAre" size:16.0]];
    }
    //picker view array is the datasource
    [pickerLabel setText:[self.pickerArray objectAtIndex:row]];
    return pickerLabel;
}


//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.materiaSelecionada = [self.pickerArray objectAtIndex:row];
}

//fim configuracoes pickerView



//incio configuracoes sliders

- (IBAction)mudaAnoMinimoConsiderado:(id)sender {
    
    self.anoMinimoConsiderado = self.sliderAnoMinimoConsiderado.value;
    self.sliderAnoMaximoConsiderado.minimumValue = self.anoMinimoConsiderado;
    
    //if para evitar bug de ano maximo < ano minimo
    if(self.anoMaximoConsiderado< self.anoMinimoConsiderado){
        self.sliderAnoMaximoConsiderado.value = self.anoMinimoConsiderado;
        self.anoMaximoConsiderado = self.anoMinimoConsiderado;
    }
}
- (IBAction)mudaAnoMaximoConsiderado:(id)sender {
    self.anoMaximoConsiderado = self.sliderAnoMaximoConsiderado.value;
}

-(void)setAnoMinimoConsiderado:(int)anoMinimoConsiderado{
    _anoMinimoConsiderado = anoMinimoConsiderado;
    self.labelAnoMinimoConsiderado.text = [NSString stringWithFormat:@"%d",self.anoMinimoConsiderado];
}


-(void)setAnoMaximoConsiderado:(int)anoMaximoConsiderado{
    _anoMaximoConsiderado = anoMaximoConsiderado;
    self.labelAnoMaximoConsiderado.text = [NSString stringWithFormat:@"%d",self.anoMaximoConsiderado];
}
//fim configuracaoes slider


- (NSMutableArray*)geraVetorIntervalo{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(int i= self.anoMinimoConsiderado;i<=self.anoMaximoConsiderado;i++)
        [array addObject:[NSNumber numberWithInt:i]];
    return array;
}

- (NSMutableArray*)geraVetorFases{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    if (self.switch1Fase.on)
        [array addObject:@1];
    
    if (self.switch2Fase.on)
        [array addObject:@2];
    
    return array;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"rankingTela"]) {
        TableRankingViewController *vc = (TableRankingViewController*)[segue destinationViewController];
        vc.materiaSelecionada = self.materiaSelecionada;
        vc.arrayFases = [self geraVetorFases];
        vc.arrayPeriodo = [self geraVetorIntervalo];
        vc.selectedExam = self.selectedExam;
        vc.managedObjectContext = self.managedObjectContext;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
