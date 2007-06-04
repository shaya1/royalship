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

unit UJoueur;

interface

uses Affichage,Uiarbitre;

type IJoueur = class
	fAff: TForm1;
	
	constructor Create(aAff: TForm1); virtual;
	destructor Destroy; virtual;
	
	function Jouer: TCase; virtual; abstract;
	
	// Résultat de notre coup précédent
	procedure ToucheAdversaire(bateau: integer); virtual; abstract; // Adversaire touché
	procedure CouleAdversaire(bateau: integer); virtual; abstract; // Adversaire coulé
	procedure Rate; virtual; abstract; // Coup à l'eau
	procedure Invalide; virtual;abstract;
	
	// Résultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); virtual; abstract; // On a été touché
	procedure CouleJoueur(coup: TCase); virtual; abstract; // On a été coulé
	
	// Fin de jeu
	procedure Gagne; virtual;abstract;
	procedure Perd; virtual;abstract;

	// Début de partie
	Procedure PlaceBateau(tailleBateau: integer; var C: TCase; var direction: integer); virtual; abstract;
    Procedure PlacementOK(tailleBateau: integer; Cases: array of TCase); virtual; abstract;
    Procedure PlacementInvalide; virtual;abstract;
	
	procedure debug; virtual;
end;

implementation

constructor IJoueur.Create(aAff: TForm1);
begin
	fAff := aAff;
end;

destructor IJoueur.Destroy;
begin
	
end;

procedure IJoueur.debug;
begin;
	
end;

end.
