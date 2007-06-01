// ~ master: bataillenavale.lpr

unit Affichage;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls, Uiarbitre;

var arbitre:Iarbitre;
    LastCase:Tcase;
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
    procedure OnMouseDown(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure SetArbitre(AArbitre:IArbitre);
    Procedure ChangerMessage(A:string);
    Procedure GrilleHumainTouche(C:TCase);
    Procedure GrilleOrdinateurTouche(C:TCase);
    Procedure GrilleOrdinateurLoupe(C:Tcase);
    Procedure coloriecase(C:Tcase;couleur:Tcolor;StringgridA:Tstringgrid);
    Function DernierecaseCliquee:Tcase;

  private
    { private declarations }
  public
    { public declarations }
  end; 

implementation

{ TForm1 }
Procedure Tform1.SetArbitre(AArbitre:IArbitre);
Begin
  Arbitre:=AArbitre;
End;

procedure TForm1.OnMouseDown(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Stringgrid2.MousetoCell(X,Y,LastCase[0],LastCase[1]);
  LastCase[0] := LastCase[0] - 1;
  LastCase[1] := LastCase[1] - 1;
  if (0 <= LastCase[0]) and (0 <= LastCase[1]) and (9 >= LastCase[0]) and (9 >= LastCase[1]) then
    Arbitre.Tour;
end;

Function Tform1.DernierecaseCliquee:Tcase;
Begin
  DernierecaseCliquee := LastCase;
End;

procedure TForm1.ChangerMessage(A: string);
begin
  writeln('Message: ', A);
  Edit6.Text:=A;
end;
  
Procedure Tform1.coloriecase(C:Tcase;couleur:Tcolor;StringgridA:Tstringgrid);
Var Casegrid:TRect;
    sCouleur: string;
begin
  //~ Casegrid:=StringGridA.CellRect(C[0],C[1]);
  //~ StringGridA.canvas.brush.color:=couleur;
  //~ StringGridA.canvas.FillRect(Casegrid);
  sCouleur := 'inconnue';
  if couleur = clred then
    sCouleur := 'rouge';
  if couleur = clblue then
    sCouleur := 'bleu';
  C[0] := C[0] + 1;
  C[1] := C[1] + 1;
  StringGridA.Cells[C[0],C[1]] := sCouleur;
End;

procedure TForm1.GrilleHumainTouche(C: TCase);
Begin
  writeln('GrilleHumainLoupe: ', C[0], ' ', C[1]);
  ColorieCase(C,clred,Stringgrid1);
end;

procedure TForm1.GrilleOrdinateurTouche(C: TCase);
Begin
  writeln('GrilleOrdinateurTouche: ', C[0], ' ', C[1]);
  ColorieCase(C,clred,Stringgrid2);
End;

procedure TForm1.GrilleOrdinateurLoupe(C: Tcase);
Begin
  writeln('GrilleOrdinateurLoupe: ', C[0], ' ', C[1]);
  ColorieCase(C,clblue,Stringgrid2);
end;

initialization
  {$I affichage.lrs}


end.

