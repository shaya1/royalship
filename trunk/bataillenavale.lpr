// ~ deps: affichage.pas ucarbitre.pas uiarbitre.pas ujoueuria.pas ujoueurhumain.pas

program bataillenavale;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
   cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, Affichage, UIarbitre,Ujoueur,Ucarbitre, ujoueuria, ujoueurhumain;

Var Form1:TForm1;
    JoueurH, JoueurO: IJoueur;
    Arbitre: CArbitre;
begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  JoueurH := CJoueurHumain.Create(Form1);
  JoueurO := CJoueurIA.Create(Form1);
  Arbitre := CArbitre.Create;
  Arbitre.AjouterJoueur(JoueurH, JoueurO);
  Form1.SetArbitre(Arbitre);
  Application.Run;
  Arbitre.Destroy;
  JoueurH.Destroy;
  JoueurO.Destroy;
end.

