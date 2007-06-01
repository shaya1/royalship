// ~ master: bataillenavale.lpr

unit UCarbitre;

{$mode objfpc}{$H+}

interface

uses Classes,UIarbitre, UJoueur, SysUtils;

Type Tplateau=array [1..10,1..10] of Integer;

Type Carbitre=Class (Iarbitre)
Private
  fJH:Ijoueur;
  fJo:Ijoueur;

  PlateauH:TPlateau;
  PlateauO:TPlateau;

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
  For i:=1 to 10 do
    For j:=1 to 10 do
      Begin
        PlateauH[i,j]:=0;
        PlateauO[i,j]:=0;
      end;
  
  fJH:=aj1;
  fJO:=aj2;
End;

Destructor Carbitre.Destroy();
Begin
End;

Procedure Carbitre.Tour();
  Procedure Coup(J1,J2:Ijoueur;P2:TPlateau);
    Function VerifNaufrage(Bat:Integer;P2:Tplateau):boolean;
    Var i,j:integer;
    Begin
      VerifNaufrage:=True;
      For i:=0 to 9 do
        For j:=0 to 9 do
          If P2[i,j]=Bat
            then VerifNaufrage:=False
    End;
  Var A:TCase;
  Begin
    Repeat
      A:=J1.jouer;
    Until P2[A[0],A[1]]>=0;
    
    writeln('en ', A[0], ',', A[1]);

    If P2[A[0],A[1]]=0 then
      J1.Rate
    else begin
      If VerifNaufrage(P2[A[0],A[1]],P2)=False then begin
        J1.ToucheAdversaire;
        J2.ToucheJoueur(A);
      end else begin
        J1.Couleadversaire;
        J2.CouleJoueur(A);
      end;
    end;
  end;
Begin
  writeln('');
  write('Humain joue ');
  Coup(fJh,fJo,PlateauO);
  writeln('');
  writeln('Ordinateur joue ');
  Coup(fJo,fJh,PlateauH);
end;

end.

