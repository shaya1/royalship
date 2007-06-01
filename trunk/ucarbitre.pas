// ~ master: bataillenavale.lpr

unit UCarbitre;

{$mode objfpc}{$H+}

interface

uses Classes,UIarbitre, UJoueur, SysUtils;

Type Tplateau=array [0..9,0..9] of Integer;

Type Carbitre=Class (Iarbitre)
Private
  fJH:Ijoueur;
  fJo:Ijoueur;

  PlateauH:TPlateau;
  PlateauO:TPlateau;
  
  procedure debug;

Public
  Constructor Create();
  Destructor Destroy();
  Procedure AjouterJoueur(aj1,aj2:Ijoueur);
  
  Procedure Tour();override;
end;

implementation

Constructor Carbitre.Create();
Begin
End;

Procedure Carbitre.AjouterJoueur(aj1,aj2:Ijoueur);
Var i,j : integer;
Begin
  For i:=0 to 9 do
    For j:=0 to 9 do
      Begin
        PlateauH[i,j]:=0;
        PlateauO[i,j]:=0;
      end;
  
  PlateauH[2,3] := 1;
  PlateauH[2,4] := 1;
  PlateauH[2,5] := 1; 
  
  PlateauO[1,6] := 1;
  PlateauO[1,7] := 1; 
  PlateauO[1,8] := 1; 
  
  fJH:=aj1;
  fJO:=aj2;
End;

Destructor Carbitre.Destroy();
Begin
End;

Procedure Carbitre.Tour();
  function Coup(J1,J2:Ijoueur;var P2:TPlateau): boolean;
    Function VerifNaufrage(Bat:Integer;var P2:Tplateau):boolean;
    Var i,j:integer;
    Begin
      VerifNaufrage:=True;
      For i:=0 to 9 do
        For j:=0 to 9 do
          If P2[i,j]=Bat then
            VerifNaufrage:=False
    End;
  Var A:TCase;
      C: boolean;
  Begin
    A:=J1.jouer;
    Coup := P2[A[0],A[1]]>=0;
    C := P2[A[0],A[1]]>=0;
    
    if C then begin
      writeln('en ', A[0], ',', A[1]);
      If P2[A[0],A[1]]=0 then
        J1.Rate
      else begin
        P2[A[0],A[1]] := P2[A[0],A[1]] * -1;
        If VerifNaufrage(P2[A[0],A[1]] * -1,P2)=False then begin
          J1.ToucheAdversaire;
          J2.ToucheJoueur(A);
        end else begin
          J1.Couleadversaire;
          J2.CouleJoueur(A);
        end;
      end;
    end else
      J1.invalide;
  end;
Begin
  writeln('');
  write('Humain joue ');
  if Coup(fJh,fJo,PlateauO) then
    repeat
      writeln('');
      writeln('Ordinateur joue ');
    until Coup(fJo,fJh,PlateauH);
end;

procedure CArbitre.debug;
var i, j: integer;
begin
  for i := 0 to 9 do begin
    for j := 0 to 9 do
      write(PlateauO[j,i], ' ');
    writeln('');
  end;
end;

end.

