// ~ deps: affichage.pas ucarbitre.pas uiarbitre.pas UJoueurIA.pas UJoueur.pas

program bataillenavale;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
   cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, Affichage, UIarbitre,Ucarbitre, ujoueuria, ujoueur;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

