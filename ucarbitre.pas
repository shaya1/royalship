unit UCarbitre;

{$mode objfpc}{$H+}

interface

uses
  Classes,UIarbitre, SysUtils;

Type Tplateau=array [1..10,1..10] of Integer;

Type Ijoueur=Class
     end;
     
Type Carbitre=Class (Iarbitre)

               //attributs
               Public
               fJH:Ijoueur;
               fJo:Ijoueur;
               
               Private
               PlateauH:TPlateau;
               PlateauO:TPlateau;

               //methodes

               Public
               Constructor Create();
               Destructor Destroy();
               Procedure AjouterJoueur(aj1,aj2:Ijoueur);
               
               Private
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

    Procedure Coup(J1,J2:Ijoueur;P2:Plateau);
      Var A:TCase;
    Begin
      A:=J1.jouer;

        If P2[A(0),A(1)]=0
        then J1.Rate
        else
          Begin
          J1.Toucheadversaire;
          J1.ToucheJoueur;
          J1.Couleadversaire;
          J1.Coulejoueur;
          end;
    end;

Begin

Coup(fJh,fJo,PlateauO);
Coup(fJo,fJh,PlateauH);

end;

end.

