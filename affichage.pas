// ~ master: bataillenavale.lpr

unit Affichage;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Procedure ChangerMessage(A:string);
    Procedure GrilleHumainTouche(C:TCase);
    Procedure GrilleOrdinateurTouche(C:TCase);
    Procedure GrilleOrdinateurLoupe(C:Tcase);
    procedure StringGrid2Click(Sender: TObject);
    

  private
    { private declarations }
  public
    { public declarations }
  end; 

implementation

{ TForm1 }

procedure TForm1.ChangerMessage(A: string);
  begin
  Edit6.Text:=A;
  end;
  
Procedure Tform1.coloriecase(C:Tcase;couleur:Tcolor;StringgridA:Tstringgrid);
  Var Casegrid:TRect;
  begin
  Casegrid:=StringGridA.CellRect(C[0],C[1]);
  StringGridA.canvas.brush.color:=couleur;
  StringGridA.canvas.FillRect(Casegrid);
  End;

procedure TForm1.GrilleHumainTouche(C: TCase);

  Begin
  ColorieCase(C,clred,Stringgrid1);
  end;

procedure TForm1.GrilleOrdinateurTouche(C: TCase);

  Begin
  ColorieCase(C,clred,Stringgrid2);
  End;
end;

procedure TForm1.GrilleOrdinateurLoupe(C: Tcase);

  Begin
  ColorieCase(C,clblue,Stringgrid2);
  end;

procedure TForm1.StringGrid2Click(Sender: TObject;Arbitre:IJoueur);
begin
Arbitre.Tour();
end;

initialization
  {$I affichage.lrs}


end.

