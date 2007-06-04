// ~ master: bataillenavale.lpr

unit Affichage;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls, Uiarbitre, Buttons;

var arbitre:Iarbitre;
    LastCase:Tcase;
    LastDirection:integer;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
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
    Procedure SetArbitre(AArbitre:IArbitre);
    Procedure ChangerMessage(A:string);
    Procedure PositionBateau(C:Tcase);
    Procedure GrilleHumainTouche(C:TCase);
    Procedure GrilleOrdinateurTouche(C:TCase);
    Procedure GrilleOrdinateurLoupe(C:Tcase);
    Procedure coloriecase(C:Tcase;couleur:Tcolor;Var StringgridA:Tstringgrid);
    Function DernierecaseCliquee:Tcase;
    Function Dernieredirection:integer;
    procedure StringGrid1MouseDown(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid2MouseDown(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { private declarations }
  public
    { public declarations }
  end; 

implementation

{ TForm1 }
//initialisation de l'arbitre
Procedure Tform1.SetArbitre(AArbitre:IArbitre);
Begin
  Arbitre:=AArbitre;
End;

//Action à réaliser sur le clic
//Procedure de placement des bateaux quand on clic sur Stringgrid1 et quand Arbitre.Miseenplaceeff=False
procedure TForm1.StringGrid1MouseDown(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbright then
    Lastdirection:=1
  else
    Lastdirection:=0;
  
  If Arbitre.JeuEnCours=False then
  begin
    Stringgrid1.MousetoCell(X,Y,LastCase[0],Lastcase[1]);
    LastCase[0]:=LastCase[0]-1;
    LastCase[1]:=LastCase[1]-1;
  
    if (LastCase[0] >= 0) and (LastCase[1] >= 0) then
      Arbitre.MiseEnPlace;
    
    If Arbitre.JeuEnCours then begin
      ChangerMessage('Navires en Position !!! Parés pour le combat !!');
    End;
  end;
end;

procedure TForm1.StringGrid2MouseDown(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i, j: integer;
    C: TCase;
begin
  If Arbitre.JeuEnCours=True then begin
    Stringgrid2.MousetoCell(X,Y,LastCase[0],LastCase[1]);
    LastCase[0] := LastCase[0] - 1;
    LastCase[1] := LastCase[1] - 1;
    if (0 <= LastCase[0]) and (0 <= LastCase[1]) and (9 >= LastCase[0]) and (9 >= LastCase[1]) then
      Arbitre.Tour;
    
    if Arbitre.JeuEnCours = False then
    begin
      Stringgrid1.Clean([gzNormal, gzFixedRows]);
      Stringgrid2.Clean([gzNormal, gzFixedRows]);
    end;
  end;
end;

//Renvoi de la dernière case et le dernier bouton cliqués dont JoueurHumain a besoin
Function Tform1.DernierecaseCliquee:Tcase;
Begin
  DernierecaseCliquee := LastCase;
End;

Function Tform1.Dernieredirection:integer;
Begin
  Dernieredirection:= LastDirection;
End;

//Gestion de la boîte à message
procedure TForm1.ChangerMessage(A: string);
begin
  Edit6.Text:=A;
end;

//Fonction de coloriage
Procedure Tform1.coloriecase(C:Tcase;couleur:Tcolor;Var StringgridA:Tstringgrid);
Var Casegrid:TRect;
begin
  Casegrid:=StringGridA.CellRect(C[0]+1,C[1]+1);
  StringGridA.canvas.brush.color:=couleur;
  StringGridA.canvas.FillRect(Casegrid);
End;

//Fonctions déterminant le choix de la couleur de la case
Procedure Tform1.PositionBateau(C:Tcase);
Begin
ColorieCase(C,Clgreen,Stringgrid1);
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

