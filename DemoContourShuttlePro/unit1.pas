unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ReadDevInput_ContourShuttlePro, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    InputComp_CSP1: TInputComp_CSP;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure InputComp_CSP1Button0Down(Sender: TObject);
    procedure InputComp_CSP1ButtonDown(Sender: TObject; Button: integer);
    procedure InputComp_CSP1ButtonUp(Sender: TObject; Button: integer);
    procedure InputComp_CSP1DialChange(Sender: TObject; Dialposition: byte);
    procedure InputComp_CSP1StatusChanged(Sender: TObject; Buttons: word;
      DialPos: byte; WheelPos: TWheelpos; WhhelPos_High_Res: integer);
    procedure InputComp_CSP1WheelChange(Sender: TObject; WheelPosition: TWheelpos);
    procedure InputComp_CSP1Wheel_High_ResChange(Sender: TObject; Wheelpos_High_Res: integer);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.InputComp_CSP1DialChange(Sender: TObject; Dialposition: byte);
begin
  LabeledEdit3.Text:=inttostr(Dialposition);
end;

procedure TForm1.InputComp_CSP1StatusChanged(Sender: TObject; Buttons: word;
  DialPos: byte; WheelPos: TWheelpos; WhhelPos_High_Res: integer);
begin
  LabeledEdit6.Text:= BinStr(Buttons,16);
end;

procedure TForm1.InputComp_CSP1WheelChange(Sender: TObject;
  WheelPosition: TWheelpos);
begin
  LabeledEdit4.Text:=inttostr(Wheelposition);
end;


procedure TForm1.InputComp_CSP1Wheel_High_ResChange(Sender: TObject;
  Wheelpos_High_Res: integer);
begin
 LabeledEdit5.Text :=inttostr(Wheelpos_High_Res);
end;

procedure TForm1.InputComp_CSP1Button0Down(Sender: TObject);
begin
 // label1.caption:='b1';
end;

procedure TForm1.InputComp_CSP1ButtonDown(Sender: TObject; Button: integer);
begin
  LabeledEdit1.Text:=inttostr(Button);
end;

procedure TForm1.InputComp_CSP1ButtonUp(Sender: TObject; Button: integer);
begin
  LabeledEdit2.Text:=inttostr(Button);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  InputComp_CSP1.SetDevice('/dev/input/by-id/usb-Contour_Design_ShuttlePRO_v2-event-if00');
//  InputComp_CSP1.FindDevice;
  InputComp_CSP1.enabled:=true;;
end;

procedure TForm1.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
// form1.caption:=inttostr(wheeldelta);
end;

end.

