unit UJoueurHumain;

interface 

uses UJoueur,uiarbitre,affichage;

type CJoueurHumain = class(IJoueur)
	
	constructor Create(aAff: TForm1); override;
	destructor Destroy; override;
	
	function Jouer: TCase; override;
	
	// R�sultat de notre coup pr�c�dent
	procedure ToucheAdversaire; override; // Adversaire touch�
	procedure CouleAdversaire; override;  // Adversaire coul�
	procedure Rate; override; // Coup � l'eau
	
	// R�sultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); override; // On a �t� touch�
	procedure CouleJoueur(coup: TCase); override; // On a �t� coul�
	
	// Autre
	procedure Gagne; override;
	procedure Perd; override;
	procedure Invalide; override;

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

procedure CJoueurHumain.ToucheAdversaire;
begin
	fAff.ChangerMessage('Touche !');
	fAff.GrilleOrdinateurTouche(fdernierCoup);
end;

procedure CJoueurHumain.CouleAdversaire;
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

procedure CJoueurHumain.Gagne;
begin
	fAff.ChangerMessage('Gagne \o/');
end;

procedure CJoueurHumain.Perd;
begin
	fAff.ChangerMessage('Perdu...');
end;

end.
