// ~ master: bataillenavale.lpr

unit UJoueurIA;

interface

uses Affichage,UJoueur,uiarbitre;

type CJoueurIA = class(IJoueur)
	constructor Create(aAff: TForm1); override;

	function Jouer: TCase; override;
	
	procedure ToucheAdversaire; override;
	procedure CouleAdversaire; override;
	procedure Rate; override;
	
	procedure ToucheJoueur(coup: TCase); override;
	procedure CouleJoueur(coup: TCase); override;
	
	procedure Gagne; override;
	procedure Perd; override;
	procedure Invalide; override;

private
	procedure debug;

	fPlateau: array[0..11,0..11] of integer; // 0: inconnu, 1: bateau, 2: coup à l'eau
	fSize: integer; // taille pile
	fPile: array[0..99] of TCase;
	fDernierCoup: TCase;
end;

implementation

constructor CJoueurIA.Create(aAff: TForm1);
var i, j: integer;
begin
	randomize;
	
	fAff := aAff;

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
	//~ debug;
	if fSize = 0 then begin
		repeat
			c[0] := random(10);
			c[1] := random(10);
		until fPlateau[c[0],c[1]]=0;
		
		Jouer := c;
		fDernierCoup := c;
	end else begin
		depile := True;
		c := fPile[fSize-1];
		
		for di := -1 to 1 do
			for dj := -1 to 1 do
				if fPlateau[c[0]+di,c[1]+dj] = 0 then begin
					depile := False;
					c2[0] := c[0]+di;
					c2[1] := c[1]+dj;
				end;
		
		if depile then begin
			fSize := fSize - 1;
			Jouer := Jouer;
		end else begin
			Jouer := c2;
			fDernierCoup := c2;
		end
	end
end;

procedure CJoueurIA.ToucheAdversaire;
begin
	writeln('IA: AdvTouche (', fDernierCoup[0], ',', fDernierCoup[1], ')');
	fPlateau[fDernierCoup[0],fDernierCoup[1]]:=1;
	fPile[fSize] := fDernierCoup;
	fSize := fSize + 1;
end;

procedure CJoueurIA.CouleAdversaire;
begin
	writeln('IA: AdvCoule (', fDernierCoup[0], ',', fDernierCoup[1], ')');
end;

procedure CJoueurIA.Rate;
begin
	writeln('IA: Rate (', fDernierCoup[0], ',', fDernierCoup[1], ')');
	fPlateau[fDernierCoup[0],fDernierCoup[1]]:=2;
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
	
end;

procedure CJoueurIA.Perd;
begin
	
end;

procedure CJoueurIA.debug;
var i, j: integer;
begin
	for i := 1 to 10 do begin
		for j := 1 to 10 do begin
			write(fPlateau[i,j], ' ');
		end;
		writeln('');
	end;
end;

end.
