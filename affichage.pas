(* Copyright (c) 2007 Cheikh Malik,
 *                    Kechai Icham,
 *                    Lipp Simon
 *                    
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 *)

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
    BitBtn1: TBitBtn;
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
    Label9: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1MouseDown(Sender: TOBject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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



//Action � r�aliser sur le clic
//Procedure de placement des bateaux quand on clic sur Stringgrid1 et quand Arbitre.Miseenplaceeff=False
procedure TForm1.StringGrid1MouseDown(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbright then
    Lastdirection:=1
  else
    Lastdirection:=0;
  
  If (Arbitre.JeuEnCours=False) and (Button1.Enabled=False) then
  begin
    Stringgrid1.MousetoCell(X,Y,LastCase[0],Lastcase[1]);
    LastCase[0]:=LastCase[0]-1;
    LastCase[1]:=LastCase[1]-1;
  
    if (LastCase[0] >= 0) and (LastCase[1] >= 0) then
      Arbitre.MiseEnPlace;
    
    If Arbitre.JeuEnCours then begin
      ChangerMessage('Navires en Position !!! Par�s pour le combat !!');
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
      Button1.Enabled:=True;
  end;
end;

procedure TForm1.Button1MouseDown(Sender: TOBject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Arbitre.JeuEnCours = False then
    begin
      Stringgrid1.Clean([gzNormal, gzFixedRows]);
      Stringgrid2.Clean([gzNormal, gzFixedRows]);
      Button1.Enabled:=False;
    end;
end;

//Renvoi de la derni�re case et le dernier bouton cliqu�s dont JoueurHumain a besoin
Function Tform1.DernierecaseCliquee:Tcase;
Begin
  DernierecaseCliquee := LastCase;
End;

Function Tform1.Dernieredirection:integer;
Begin
  Dernieredirection:= LastDirection;
End;

//Gestion de la bo�te � message
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

//Fonctions d�terminant le choix de la couleur de la case
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

