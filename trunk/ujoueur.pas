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
	procedure ToucheAdversaire; virtual; abstract; // Adversaire touché
	procedure CouleAdversaire; virtual; abstract; // Adversaire coulé
	procedure Rate; virtual; abstract; // Coup à l'eau
	
	// Résultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); virtual; abstract; // On a été touché
	procedure CouleJoueur(coup: TCase); virtual; abstract; // On a été coulé

    Procedure PlaceBateau(C:Tcase); virtual;abstract;
	procedure Gagne; virtual;abstract;
	procedure Perd; virtual;abstract;
	procedure Invalide; virtual;abstract;

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
