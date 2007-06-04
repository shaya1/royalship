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

unit UJoueurIA;

interface

uses Affichage,UJoueur,uiarbitre;

type CJoueurIA = class(IJoueur)
	constructor Create(aAff: TForm1); override;

	function Jouer: TCase; override;
	
	procedure ToucheAdversaire(bateau: integer); override;
	procedure CouleAdversaire(bateau: integer); override;
	procedure Rate; override;
	
	procedure ToucheJoueur(coup: TCase); override;
	procedure CouleJoueur(coup: TCase); override;
	
	procedure Gagne; override;
	procedure Perd; override;
	procedure Invalide; override;

	Procedure PlaceBateau(tailleBateau: integer; var C: TCase; var direction: integer); override;
    Procedure PlacementOK(tailleBateau: integer; Cases: array of TCase); override;
    Procedure PlacementInvalide;  override;
	
	procedure debug; override;
private
	procedure InitJeu;
	
	fPlateau: array[0..11,0..11] of integer; // 0: inconnu, 1: bateau, 2: coup à l'eau
	fSize: integer; // taille pile
	fPile: array[0..99] of TCase;
	fDernierCoup: TCase;
end;

implementation

constructor CJoueurIA.Create(aAff: TForm1);
begin
	fAff := aAff;
	InitJeu;
end;

procedure CJoueurIA.InitJeu;
var i, j: integer;
begin
	randomize;
	
	for i := 1 to 10 do
		for j := 1 to 10 do
			fPlateau[i,j] := 0;
	
	for i := 0 to 11 do begin
		fPlateau[0,i] := 2;
		fPlateau[i,0] := 2;
		fPlateau[11,i] := 2;
		fPlateau[i,11] := 2;
	end;
	
	fSize := 0;
end;

function CJoueurIA.Jouer: TCase;
var c, c2: TCase;
    di, dj: integer;
	depile: boolean;
begin
	//~ ////writeln('Plateau humain, selon IA (avant coup)');
	//~ debug;
	if fSize = 0 then begin // Tous les coups réussis ont ete explorés, on joue aléatoirement
		repeat
			c[0] := random(10);
			c[1] := random(10);
		until fPlateau[c[0]+1,c[1]+1]=0; // on ne joue pas sur une case dejà jouée...
		
		Jouer := c;
		fDernierCoup := c;
	end else begin // on explore autour des coups réussis
		depile := True;
		c := fPile[fSize-1]; // dernier coup réussi
		
		for di := -1 to 1 do
			for dj := -1 to 1 do
				if (fPlateau[c[0]+di+1,c[1]+dj+1] = 0) and ((di = 0) or (dj = 0)) then begin
					// pas encore joué sur cette case
					depile := False;
					c2[0] := c[0]+di;
					c2[1] := c[1]+dj;
				end;
		
		if depile then begin
			// tous les coups autour de la dernière case réussie ont été explorés
			// on retire le coup de la liste des coups à explorer
			fSize := fSize - 1;
			Jouer := self.Jouer;
		end else begin
			Jouer := c2;
			fDernierCoup := c2;
		end
	end
end;

procedure CJoueurIA.ToucheAdversaire(bateau: integer);
begin
	////writeln('IA: AdvTouche (', fDernierCoup[0], ',', fDernierCoup[1], ')');
	fPlateau[fDernierCoup[0]+1,fDernierCoup[1]+1]:=1;
	fPile[fSize] := fDernierCoup;
	fSize := fSize + 1;
end;

procedure CJoueurIA.CouleAdversaire(bateau: integer);
begin
	////writeln('IA: AdvCoule (', fDernierCoup[0], ',', fDernierCoup[1], ')');
	fPlateau[fDernierCoup[0]+1,fDernierCoup[1]+1]:=1;
	fPile[fSize] := fDernierCoup;
	fSize := fSize + 1;
end;

procedure CJoueurIA.Rate;
begin
	////writeln('IA: Rate (', fDernierCoup[0], ',', fDernierCoup[1], ')');
	fPlateau[fDernierCoup[0]+1,fDernierCoup[1]+1]:=2;
end;

procedure CJoueurIA.ToucheJoueur(coup: TCase);
begin

end;

procedure CJoueurIA.CouleJoueur(coup: TCase);
begin
	
end;

procedure CJoueurIA.Invalide;
begin
	
end;

procedure CJoueurIA.Gagne;
begin
	InitJeu;
end;

procedure CJoueurIA.Perd;
begin
	InitJeu;
end;

procedure CJoueurIA.debug;
var i, j: integer;
begin
	//~ for i := 1 to 10 do begin
		//~ for j := 1 to 10 do begin
			//~ //write(fPlateau[j,i], ' ');
		//~ end;
		//~ ////writeln('');
	//~ end;
	
	//write('Pile (', fSize, '): ');
	for i := 0 to fSize - 1 do begin
		//write('(', fPile[i][0],',', fPile[i][1],') ')
	end;
	////writeln('');
end;

Procedure CJoueurIA.PlacementOK(tailleBateau: integer; Cases: array of TCase);
var i: integer;
Begin
	
end;

Procedure CJoueurIA.PlacementInvalide;
Begin
	
end;

Procedure CJoueurIA.PlaceBateau(tailleBateau: integer; var C: TCase; var direction: integer);
begin
	C[0] := random(10);
	C[1] := random(10);
	direction := random(2);
end;

end.
