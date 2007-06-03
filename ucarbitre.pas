// ~ master: bataillenavale.lpr

unit UCarbitre;

{$mode objfpc}{$H+}

interface

uses Classes,UIarbitre, UJoueur, SysUtils;

Type Tplateau=array [0..9,0..9] of Integer;

Type Carbitre=Class (Iarbitre)

  fJH:Ijoueur;
  fJo:Ijoueur;

  PlateauH:TPlateau;
  PlateauO:TPlateau;
  
Public
  Constructor Create();
  Destructor Destroy();
  Procedure AjouterJoueur(aj1,aj2:Ijoueur);

  Procedure Tour();override;
  Procedure MiseEnPlace(Bateau:integer);override;
end;

implementation

Constructor Carbitre.Create();
Begin
MiseenPlaceEff:=False;
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

  PlateauO[1,6] := 1;
  PlateauO[1,7] := 1; 
  PlateauO[1,8] := 1; 
  
  fJH:=aj1;
  fJO:=aj2;
End;

Destructor Carbitre.Destroy();
Begin
End;

Procedure Carbitre.MiseEnPlace(Bateau:integer);
(*--------------------------Codes Bateaux----------------------------
2 Frégate
3 Sous-Marin et contre-Torpilleur
4 Torpilleur
5 Porte avions
----------------------------Codes directions-------------------------
TRUE Horizontal
FALSE Vertical
----------------------------Codes sens-------------------------------
TRUE sens croissant
FALSE sens décroissant*)

  Procedure VerifCollision(Bateau:integer;Plateau1:Tplateau;C:Tcase;Direction:Boolean; Var Possible:Boolean;Var SensPossible:Boolean);
  Var i:integer;
  Begin
  SensPossible:=True;
  i:=0;
    If Direction=True
    then
      Repeat
        if C[1]+Bateau<=10
        then
          Begin
          Possible:=(Plateau1[C[0],C[1]+i]=0);
          SensPossible:=True;
          end
        else
            Begin
            Possible:=(Plateau1[C[0],C[1]-i]=0);
            SensPossible:=False;
            end;
        i:=i+1;
      Until (Possible=False) or (i=Bateau)
    Else
      Repeat
        if C[0]+Bateau<=10
        then
          Begin
          Possible:=(Plateau1[C[0]+i,C[1]]=0);
          SensPossible:=True;
          end
        else
            Begin
            Possible:=(Plateau1[C[0]-i,C[1]]=0);
            SensPossible:=False;
            end;
        i:=i+1;
      Until  (i=Bateau) or (Possible=False);
    end;
    
    Procedure MiseajourPlateau(J1:Ijoueur;Var Plateau1:Tplateau;Bateau:integer;C:Tcase;Direction,Possible,SensPossible:boolean);
    Var i:integer;Caux:Tcase;
    Begin
    Caux[0]:=C[0];
    Caux[1]:=C[1];
    If Possible=False
    then J1.faff.ChangerMessage('La position de votre navire est invalide. Choisissez un autre endroit')
    else
      Begin
      If Direction=True
        then
          If SensPossible=True
          then
            Begin
            For i:=0 to Bateau-1 do
            Begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[1]:=Caux[1]+1;
            End;
            J1.faff.ChangerMessage('Navire en position !!');
            end
          else
            Begin
            For i:=0 to Bateau-1 do
            Begin
           Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[1]:=Caux[1]-1;
            End;
            J1.faff.ChangerMessage('Nous sommes prêts ici !!');
            end
        else
          If SensPossible=True
          then
            Begin
            For i:=0 to Bateau-1 do
            Begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[0]:=Caux[0]+1;
            End;
            J1.faff.ChangerMessage('Paré à faire feu !!');
            End
          else
            Begin
            For i:=0 to Bateau-1 do
            Begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[0]:=Caux[0]-1;
            End;
            J1.faff.ChangerMessage('A vos Ordres !!');
            end
       End;
     end;

Var Possible,SensPossible:boolean;C:Tcase;Direction:Boolean;
Begin
C:=fjH.faff.DerniereCaseCliquee;
Direction:=fjH.faff.DerniereDirection;
VerifCollision(Bateau,PlateauH,C,Direction,Possible,SensPossible);
MiseajourPlateau(fjH,PlateauH,Bateau,C,Direction,Possible,SensPossible);
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
      i, j: integer;
      G: boolean;
  Begin

    A:=J1.jouer;
    Coup := P2[A[0],A[1]]>=0;
    C := P2[A[0],A[1]]>=0;
    
    if C then begin
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
          
          // Verifie si le joueur a gagné (le bateau coule était le seul restant)
          G := true;
          for i := 0 to 9 do
            for j := 0 to 9 do
              if P2[i,j] > 0 then
                G := false;
          
          if G then begin
            J1.Gagne;
            J2.Perd;
          end;
        end;
      end;
    end else
      J1.invalide;
  end;
Begin
  if Coup(fJh,fJo,PlateauO) then
    repeat
      ////writeln('');
      ////writeln('Ordinateur joue ');
      //~ ////writeln('Plateau humain, selon arbitre:');
      //~ debug;
    until Coup(fJo,fJh,PlateauH);
    //~ ////writeln('Plateau humain, selon IA (apres coup):');
    //~ fJo.debug;
end;

initialization

end.

