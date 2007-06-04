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

unit UJoueurHumain;

interface 

uses UJoueur,uiarbitre,affichage;

type CJoueurHumain = class(IJoueur)
	
	constructor Create(aAff: TForm1); override;
	destructor Destroy; override;
	
	function Jouer: TCase; override;
	
	// Résultat de notre coup précédent
	procedure ToucheAdversaire(bateau: integer); override; // Adversaire touché
	procedure CouleAdversaire(bateau: integer); override;  // Adversaire coulé
	procedure Rate; override; // Coup à l'eau
	procedure Invalide; override;
	
	// Résultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); override; // On a été touché
	procedure CouleJoueur(coup: TCase); override; // On a été coulé
	
	// Début partie
	Procedure PlaceBateau(tailleBateau: integer; var C: TCase; var direction: integer); override;
    Procedure PlacementOK(tailleBateau: integer; Cases: array of TCase); override;
    Procedure PlacementInvalide;  override;

	// Fin partie
	procedure Gagne; override;
	procedure Perd; override;

private
	fDernierCoup: TCase;
end;

implementation

constructor CJoueurHumain.Create(aAff: TForm1);
var i, j: integer;
begin
	fAff := aAff;
end;

function CJoueurHumain.Jouer: TCase;
begin
	Jouer := fAff.DerniereCaseCliquee;
	fDernierCoup := fAff.DerniereCaseCliquee;
end;

procedure CJoueurHumain.ToucheAdversaire(bateau: integer);
begin
	fAff.ChangerMessage('Touche !');
	fAff.GrilleOrdinateurTouche(fdernierCoup);
end;

procedure CJoueurHumain.CouleAdversaire(bateau: integer);
begin
	fAff.ChangerMessage('Coule !');
	fAff.GrilleOrdinateurTouche(fdernierCoup);
end;

procedure CJoueurHumain.Rate;
begin
	fAff.ChangerMessage('Coup a l''eau :(');
	fAff.GrilleOrdinateurLoupe(fdernierCoup);
end;

procedure CJoueurHumain.ToucheJoueur(coup: TCase);
begin
	fAff.GrilleHumainTouche(coup);
end;

procedure CJoueurHumain.CouleJoueur(coup: TCase);
begin
	fAff.GrilleHumainTouche(coup);
end;

procedure CJoueurHumain.Invalide;
begin
	fAff.ChangerMessage('Mauvais coup, essayez encore...');
end;

Destructor CjoueurHumain.Destroy;
Begin
	
End;

Procedure CJoueurHumain.PlacementOK(tailleBateau: integer; Cases: array of TCase);
var i: integer;
Begin
	for i := 0 to tailleBateau - 1 do
		faff.PositionBateau(Cases[i]);
end;

Procedure CJoueurHumain.PlacementInvalide;
Begin
	faff.ChangerMessage('La position de votre navire est invalide. Choisissez un autre endroit')
end;

Procedure CJoueurHumain.PlaceBateau(tailleBateau: integer; var C: TCase; var direction: integer);
begin
	C := fAff.DerniereCaseCliquee;
	direction := fAff.DerniereDirection;
end;

procedure CJoueurHumain.Gagne;
begin
	fAff.ChangerMessage('ILS ONT TOUS SOMBRES DANS LES ABYSSES !!');
end;

procedure CJoueurHumain.Perd;
begin
	fAff.ChangerMessage('NOTRE DERNIER NAVIRE PREND L''EAU DE TOUTE PARTS !!!!');
end;

end.
