unit UJoueurHumain;

interface 

uses UJoueur,uiarbitre,affichage;

type CJoueurHumain = class(IJoueur)
	
	constructor Create(aAff: TForm1); override;
	destructor Destroy; override;
	
	function Jouer: TCase; override;
	
	// Résultat de notre coup précédent
	procedure ToucheAdversaire; override; // Adversaire touché
	procedure CouleAdversaire; override;  // Adversaire coulé
	procedure Rate; override; // Coup à l'eau
	procedure Invalide; override;
	
	// Résultat du coup de l'adversaire
	procedure ToucheJoueur(coup: TCase); override; // On a été touché
	procedure CouleJoueur(coup: TCase); override; // On a été coulé
	
	// Début partie
	Procedure PlaceBateau(tailleBateau: integer; var C: TCase, var direction: boolean); override;
    Procedure PlacementOK; override;
    Procedure PlacementInvalide;  override;

	// Fin partie
	procedure Gagne; override;
	procedure Perd; override;

private
	fDernierCoup: TCase;
	fDernierPlacement: TCase;
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

Procedure CJoueurHumain.PlacementOK;
Begin
	faff.PositionBateau(fDernierPlacement);
end;

Procedure CJoueurHumain.PlacementInvalide;
Begin
	faff.ChangerMessage('La position de votre navire est invalide. Choisissez un autre endroit')
end;

Procedure CJoueurHumain.PlaceBateau(tailleBateau: integer; var C: TCase, var direction: boolean);
begin
	C := fAff.DerniereCaseCliquee;
	direction := fAff.DerniereDirection;
	fDernierPlacement := C;
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
