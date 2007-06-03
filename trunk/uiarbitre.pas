// ~ master: bataillenavale.lpr

unit UIarbitre;

{$mode objfpc}{$H+}

interface

Uses SysUtils;

type TCase = array[0..1] of integer;

Type Iarbitre=Class
     MiseEnPlaceeff:Boolean;
     Constructor Create();virtual;abstract;
     Destructor  Destroy();virtual;abstract;
     Procedure Tour(); virtual;abstract;
     Procedure MiseEnPlace(Bateau:integer);virtual;abstract;
end;

implementation

initialization

end.

