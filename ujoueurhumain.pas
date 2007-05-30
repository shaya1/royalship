unit UJoueurHumain;

interface 

uses UJoueur,uiarbitre,affichage;

type CJoueurHumain = class(IJoueur)
	
	constructor Create(aAff: TForm1); virtual;
	destructor Destroy; virtual;
	
	function Jouer: TCase; virtual;
	
	// R�sultat de notre coup pr�c�dent
	procedure ToucheAdversaire; virtual; // Adversaire touch�
	procedure CouleAdversaire; virtual;  // Adversaire coul�
	procedure Rate; virtual; // Coup � l'eau
	
	// R�sultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); virtual; // On a �t� touch�
	procedure CouleJoueur(coup: TCase); virtual; // On a �t� coul�

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
	fAff.ChangerMessage('Touch� !');
	fAff.GrilleOrdinateurTouche(fdernierCoup);
end;

procedure CJoueurHumain.CouleAdversaire;
begin
	fAff.ChangerMessage('Coul� !');
end;

procedure CJoueurHumain.Rate;
begin
	fAff.ChangerMessage('Coup � l''eau :(');
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
