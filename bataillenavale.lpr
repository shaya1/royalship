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

// ~ deps: affichage.pas ucarbitre.pas uiarbitre.pas ujoueuria.pas ujoueurhumain.pas

program bataillenavale;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
   cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, Affichage, UIarbitre,Ujoueur,Ucarbitre, ujoueuria, ujoueurhumain;

Var Form1:TForm1;
    JoueurH, JoueurO: IJoueur;
    Arbitre: CArbitre;
begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  JoueurH := CJoueurHumain.Create(Form1);
  JoueurO := CJoueurIA.Create(Form1);
  Arbitre := CArbitre.Create;
  Arbitre.AjouterJoueur(JoueurH, JoueurO);
  Form1.SetArbitre(Arbitre);
  Application.Run;
  Arbitre.Destroy;
  JoueurH.Destroy;
  JoueurO.Destroy;
end.

