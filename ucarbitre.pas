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
end;

implementation

Constructor Carbitre.Create();
begin
  ProchainBateau := 6;
  EnJeu := False;
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
  Var i:integer;
  begin
    SensPossible:=1;
    i:=0;
    if Direction=1 then
      Repeat
        if C[1]+Bateau<=10 then begin
          Possible:=(Plateau1[C[0],C[1]+i]=0);
          SensPossible:=1;
        end
        else begin
          Possible:=(Plateau1[C[0],C[1]-i]=0);
          SensPossible:=-1;
        end;
        i:=i+1;
      until (Possible=False) or (i=Bateau)
    else
      Repeat
        if C[0]+Bateau<=10 then begin
          Possible:=(Plateau1[C[0]+i,C[1]]=0);
          SensPossible:=1;
        end
        else begin
          Possible:=(Plateau1[C[0]-i,C[1]]=0);
          SensPossible:=-1;
        end;
        i:=i+1;
      until  (i=Bateau) or (Possible=False);
  end;
  
  procedure MiseajourPlateau(J1:Ijoueur;Var Plateau1:Tplateau; Bateau:integer; C:Tcase; Direction:integer; Possible:boolean; SensPossible:integer);
  Var i:integer;Caux:Tcase;
  begin
    Caux[0]:=C[0];
    Caux[1]:=C[1];
    if Possible=False then
      J1.faff.ChangerMessage('La position de votre navire est invalide. Choisissez un autre endroit')
    else begin
      if Direction=1 then
        if SensPossible=1 then begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlacementOK(Caux);
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
          J1.faff.ChangerMessage('Nous sommes prêts ici !!');
        end
      else
        if SensPossible=1 then begin
          for i:=0 to Bateau-1 do begin
            Plateau1[Caux[0],Caux[1]]:=Bateau;
            J1.PlaceBateau(Caux);
            Caux[0]:=Caux[0]+1;
          end;
          J1.faff.ChangerMessage('Paré à faire feu !!');
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

Var Possible:boolean;C:Tcase;SensPossible,Direction:integer;
begin
  fjH.PlaceBateau(ProchainBateau, C, Direction);
  VerifCollision(ProchainBateau,PlateauH,C,Direction,Possible,SensPossible);
  MiseajourPlateau(fjH,PlateauH,ProchainBateau,C,Direction,Possible,SensPossible);
  ProchainBateau := ProchainBateau - 1;
  
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
          J1.ToucheAdversaire;
          J2.ToucheJoueur(A);
        end
        else begin
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
  
function Carbitre.JeuEnCours:boolean;
begin
  JeuEnCours := EnJeu;
end;

initialization

end.

