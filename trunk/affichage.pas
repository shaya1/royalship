// ~ master: bataillenavale.lpr

unit Affichage;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure StringGrid2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

implementation

{ TForm1 }

procedure TForm1.StringGrid2Click(Sender: TObject,Arbitre);
begin
Arbitre.Tour;
end;

initialization
  {$I affichage.lrs}

JoueurHumain.create(Form1);
JoueurOrdi.create(Form1);
Arbitre.Create;
Arbitre.ajouterJoueur(JoueurHumain,JoueurOrdi);

end.

