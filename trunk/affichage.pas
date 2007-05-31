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
GrilleHumaintouche(LastCase);
end;

Function Tform1.DernierecaseCliquee:Tcase;
Begin
End;

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

procedure TForm1.GrilleOrdinateurLoupe(C: Tcase);

  Begin
  ColorieCase(C,clblue,Stringgrid2);
  end;

initialization
  {$I affichage.lrs}


end.

