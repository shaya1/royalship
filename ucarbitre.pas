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
  procedure AjouterJoueur(aj1,aj2:Ijoueur);

  procedure Tour();override;
  procedure MiseEnPlace(Bateau:integer);override;
end;

implementation

Constructor Carbitre.Create();
begin
MiseenPlaceEff:=False;
end;

procedure Carbitre.AjouterJoueur(aj1,aj2:Ijoueur);
Var i,j : integer;
begin
  for i:=0 to 9 do
    for j:=0 to 9 do
      begin
        PlateauH[i,j]:=0;
        PlateauO[i,j]:=0;
      end;

  PlateauO[1,6] := 1;
  PlateauO[1,7] := 1; 
  PlateauO[1,8] := 1; 
  
  fJH:=aj1;
  fJO:=aj2;
end;

Destructor Carbitre.Destroy();
begin
end;

procedure Carbitre.MiseEnPlace(Bateau:integer);
(*--------------------------Codes Bateaux----------------------------
2 Fr�gate
3 Sous-Marin et contre-Torpilleur
4 Torpilleur
5 Porte avions
----------------------------Codes directions-------------------------
TRUE Horizontal
FALSE Vertical
----------------------------Codes sens-------------------------------
TRUE sens croissant
FALSE sens d�croissant*)

  procedure VerifCollision(Bateau:integer;Plateau1:Tplateau;C:Tcase;Direction:Boolean; Var Possible:Boolean;Var SensPossible:Boolean);
  Var i:integer;
  begin
    SensPossible:=True;
    i:=0;
    if Direction=True then
      Repeat
        if C[1]+Bateau<=10 then begin
          Possible:=(Plateau1[C[0],C[1]+i]=0);
          SensPossible:=True;
        end
        else begin
          Possible:=(Plateau1[C[0],C[1]-i]=0);
          SensPossible:=False;
        end;
        i:=i+1;
      until (Possible=False) or (i=Bateau)
    else
      Repeat
        if C[0]+Bateau<=10 then begin
          Possible:=(Plateau1[C[0]+i,C[1]]=0);
          SensPossible:=True;
        end
        else begin
          Possible:=(Plateau1[C[0]-i,C[1]]=0);
          SensPossible:=False;
        end;
        i:=i+1;
      until  (i=Bateau) or (Possible=False);
  end;
  
  procedure MiseajourPlateau(J1:Ijoueur;Var Plateau1:Tplateau;Bateau:integer;C:Tcase;Direction,Possible,SensPossible:boolean);
  Var i:integer;Caux:Tcase;
  begin
    Caux[0]:=C[0];
    Caux[1]:=C[1];
    if Possible=False then
      J1.faff.ChangerMessage('La position de votre navire est invalide. Choisissez un autre endroit')
    else begin
      if Direction=True then
        if SensPossible=True then begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[1]:=Caux[1]+1;
          end;
          
          J1.faff.ChangerMessage('Navire en position !!');
        end
        else begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[1]:=Caux[1]-1;
          end;
          J1.faff.ChangerMessage('Nous sommes pr�ts ici !!');
        end
        else if SensPossible=True then begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[0]:=Caux[0]+1;
          end;
          J1.faff.ChangerMessage('Par� � faire feu !!');
        end
        else begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[0]:=Caux[0]-1;
          end;
          J1.faff.ChangerMessage('A vos Ordres !!');
        end
    end;
  end;

Var Possible,SensPossible:boolean;C:Tcase;Direction:Boolean;
begin
  C:=fjH.faff.DerniereCaseCliquee;
  Direction:=fjH.faff.DerniereDirection;
  VerifCollision(Bateau,PlateauH,C,Direction,Possible,SensPossible);
  MiseajourPlateau(fjH,PlateauH,Bateau,C,Direction,Possible,SensPossible);
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
          J1.ToucheAdversaire;
          J2.ToucheJoueur(A);
        end
        else begin
          J1.Couleadversaire;
          J2.CouleJoueur(A);
          
          // Verifie si le joueur a gagn� (le bateau coule �tait le seul restant)
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
begin
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

