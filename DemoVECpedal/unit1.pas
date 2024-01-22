unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ReadDevInput_VecPedal, ReadDevInput;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    InputComp_VEC1: TInputComp_VEC;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure InputComp_VEC1InputEvent(Sender: TObject);
    procedure InputComp_VEC1Pedal0Down(Sender: TObject);
    procedure InputComp_VEC1Pedal0Up(Sender: TObject);
    procedure InputComp_VEC1Pedal1Down(Sender: TObject);
    procedure InputComp_VEC1Pedal1Up(Sender: TObject);
    procedure InputComp_VEC1Pedal2Down(Sender: TObject);
    procedure InputComp_VEC1Pedal2Up(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.InputComp_VEC1Pedal0Down(Sender: TObject);
begin
 Edit1.text:='Button 0 down';
end;

procedure TForm1.InputComp_VEC1InputEvent(Sender: TObject);
begin
 edit2.text:=BinStr(InputComp_VEC1.PedalStatus,4);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
// InputComp_VEC1.SetDevice('/dev/input/by-id/usb-VEC_VEC_USB_Footpedal-event-if00');
 InputComp_VEC1.enabled:=true;
end;

procedure TForm1.InputComp_VEC1Pedal0Up(Sender: TObject);
begin
 Edit1.text:='Button 0 up';
end;

procedure TForm1.InputComp_VEC1Pedal1Down(Sender: TObject);
begin
 Edit1.text:='Button 1 down';
end;

procedure TForm1.InputComp_VEC1Pedal1Up(Sender: TObject);
begin
 Edit1.text:='Button 2 up';
end;

procedure TForm1.InputComp_VEC1Pedal2Down(Sender: TObject);
begin
 Edit1.text:='Button 2 down';
end;

procedure TForm1.InputComp_VEC1Pedal2Up(Sender: TObject);
begin
 Edit1.text:='Button 2 up';
end;

end.

