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

unit UCarbitre;

{$mode objfpc}{$H+}

interface

uses Classes,UIarbitre, UJoueur, SysUtils;

Type Tplateau=array [0..9,0..9] of Integer;

Type Carbitre=Class (Iarbitre)
  EnJeu:boolean;
  ProchainBateau: integer;
  
  fJH:Ijoueur;
  fJo:Ijoueur;

  PlateauH:TPlateau;
  PlateauO:TPlateau;
  
Public
  Constructor Create();
  Destructor Destroy();
  procedure AjouterJoueur(aj1,aj2:Ijoueur);

  procedure Tour();override;
  procedure MiseEnPlace;override;
  
  function JeuEnCours: boolean; override;

  procedure InitJeu;
end;

implementation

Constructor Carbitre.Create();
begin
  
end;

procedure Carbitre.AjouterJoueur(aj1,aj2:Ijoueur);
begin
  fJH:=aj1;
  fJO:=aj2;
  
  InitJeu;
end;

procedure Carbitre.InitJeu;
Var i,j : integer;
begin
  for i:=0 to 9 do
    for j:=0 to 9 do
      begin
        PlateauH[i,j]:=0;
        PlateauO[i,j]:=0;
      end;

  ProchainBateau := 6;
  EnJeu := False;
end;

Destructor Carbitre.Destroy();
begin
end;

procedure Carbitre.MiseEnPlace;
(*--------------------------Codes Bateaux----------------------------
2 Frégate
3 Sous-Marin
4 contre-Torpilleurs
5 Torpilleur
6 Porte avions
----------------------------Codes directions-------------------------
1 Horizontal
0 Vertical
----------------------------Codes sens-------------------------------
 1 sens croissant
-1 sens décroissant *)

  procedure VerifCollision(Bateau:integer; Plateau1:Tplateau; C:Tcase; Direction:integer; Var Possible:Boolean; Var SensPossible:integer);
  Var i, dx, dy:integer;
  begin
    i:=0;
    dx := 0;
    dy := 0;
    
    if C[Direction]+Bateau<=10 then
      SensPossible := 1
    else
      SensPossible := -1;
    
    if Direction = 0 then
      dx := SensPossible
    else
      dy := SensPossible;
    
    Repeat
      Possible:=(Plateau1[C[0]+(i*dx),C[1]+(i*dy)]=0);
      i:=i+1;
    until (Possible=False) or (i=Bateau)
  end;
  
  procedure MiseajourPlateau(J1:Ijoueur;Var Plateau1:Tplateau; Bateau:integer; C:Tcase; Direction:integer; SensPossible:integer);
  Var i:integer; Caux:Tcase; Cases: array[0..5] of TCase;
  begin
    Caux[0]:=C[0];
    Caux[1]:=C[1];
    
    for i:=0 to Bateau-1 do begin
      Plateau1[Caux[0],Caux[1]]:=Bateau;
      Cases[i] := Caux;
      Caux[Direction]:=Caux[Direction]+SensPossible;
    end;
    
    J1.PlacementOK(Bateau, Cases);
  end;
   
  function PlaceBateauJoueur(J1: IJoueur; var Plateau1: TPlateau): boolean;
  Var Possible:boolean;C:Tcase;SensPossible,Direction:integer;
  begin
    J1.PlaceBateau(ProchainBateau, C, Direction);
    VerifCollision(ProchainBateau,Plateau1,C,Direction,Possible,SensPossible);
    
    if Possible=False then
      J1.PlacementInvalide
    else begin
      MiseajourPlateau(J1,Plateau1,ProchainBateau,C,Direction,SensPossible);
    end;
    
    PlaceBateauJoueur := Possible;
  end;


begin
  if PlaceBateauJoueur(fJH, PlateauH) then
  begin
    repeat until PlaceBateauJoueur(fJO, plateauO);
    ProchainBateau := ProchainBateau - 1;
  end;
  
  if ProchainBateau = 1 then
    EnJeu := True;
end;

procedure Carbitre.Tour();
  function Coup(J1,J2:Ijoueur;var P2:TPlateau): boolean;
    function VerifNaufrage(Bat:Integer;var P2:Tplateau):boolean;
    Var i,j:integer;
    begin
      VerifNaufrage:=True;
      for i:=0 to 9 do
        for j:=0 to 9 do
          if P2[i,j]=Bat then
            VerifNaufrage:=False
    end;

  var A:TCase;
      C: boolean;
      i, j: integer;
      G: boolean;
  begin

    A:=J1.jouer;
    Coup := P2[A[0],A[1]]>=0;
    C := P2[A[0],A[1]]>=0;
    
    if C then begin
      if P2[A[0],A[1]]=0 then
        J1.Rate
      else begin
        P2[A[0],A[1]] := P2[A[0],A[1]] * -1;
        if VerifNaufrage(P2[A[0],A[1]] * -1,P2)=False then begin
          J1.ToucheAdversaire(P2[A[0],A[1]] * -1);
          J2.ToucheJoueur(A);
        end
        else begin
          J1.Couleadversaire(P2[A[0],A[1]] * -1);
          J2.CouleJoueur(A);
          
          // Verifie si le joueur a gagné (le bateau coule était le seul restant)
          G := true;
          for i := 0 to 9 do
            for j := 0 to 9 do
              if P2[i,j] > 0 then
                G := false;
          
          if G then begin
            J1.Gagne;
            J2.Perd;
            InitJeu;
          end;
        end;
      end;
    end else
      J1.invalide;
  end;
begin
  if Coup(fJh,fJo,PlateauO) then
    repeat
    until Coup(fJo,fJh,PlateauH);
end;
  
function Carbitre.JeuEnCours:boolean;
begin
  JeuEnCours := EnJeu;
end;

initialization

end.

