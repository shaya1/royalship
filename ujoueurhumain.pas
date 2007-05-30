unit UJoueurHumain;

interface 

uses UJoueur,uiarbitre,affichage;

type CJoueurHumain = class(IJoueur)
	
	constructor Create(aAff: TForm1); virtual;
	destructor Destroy; virtual;
	
	function Jouer: TCase; virtual;
	
	// Résultat de notre coup précédent
	procedure ToucheAdversaire; virtual; // Adversaire touché
	procedure CouleAdversaire; virtual;  // Adversaire coulé
	procedure Rate; virtual; // Coup à l'eau
	
	// Résultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); virtual; // On a été touché
	procedure CouleJoueur(coup: TCase); virtual; // On a été coulé

	procedure Invalide;virtual;

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
end;

procedure CJoueurHumain.ToucheAdversaire;
begin
	fAff.ChangerMessage('Touché !');
	fAff.GrilleOrdinateurTouche(fdernierCoup);
end;

procedure CJoueurHumain.CouleAdversaire;
begin
	fAff.ChangerMessage('Coulé !');
end;

procedure CJoueurHumain.Rate;
begin
	fAff.ChangerMessage('Coup à l''eau :(');
	fAff.GrilleOrdinateurLoupe(fdernierCoup);
end;

procedure CJoueurHumain.ToucheJoueur(coup: TCase);
begin
	fAff.GrilleHumainTouche(coup);
end;

procedure CJoueurHumain.CouleJoueur(coup: TCase);
begin
	
end;

procedure CJoueurHumain.Invalide;
begin
	fAff.ChangerMessage('Mauvais coup, essayez encore...');
end;

Destructor CjoueurHumain.Destroy;
Begin
End;

end.
