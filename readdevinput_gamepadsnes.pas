unit ReadDevInput_GamepadSNES;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ReadDevInput;

type

  { TInputComp_GPS }

  TInputComp_GPS = class(TInputComp)
  private
    FFOnABS_XChange: TNotifyEvent;
    FFOnABS_YChange: TNotifyEvent;
    FOnButton0Down: TNotifyEvent;
    FOnButton0Up:   TNotifyEvent;
    FOnButton1Down: TNotifyEvent;
    FOnButton1Up:   TNotifyEvent;
    FOnButton2Down: TNotifyEvent;
    FOnButton2Up:   TNotifyEvent;
    FOnButton3Down: TNotifyEvent;
    FOnButton3Up:   TNotifyEvent;
    procedure SetEvent_Type1(evdata1: TInputData);
    procedure SetEvent_Type3(evdata3: TInputData);
    procedure SetFOnABS_XChange(AValue: TNotifyEvent);
    procedure SetFOnABS_YChange(AValue: TNotifyEvent);
  public
    ButtonStatus: byte;
    procedure SetEvData(evdata: TInputData);   override;
  published
    property OnButton0Down: TNotifyEvent read FOnButton0down write FOnButton0Down;
    property OnButton0Up: TNotifyEvent read FOnButton0Up write FOnButton0Up;
    property OnButton1Down: TNotifyEvent read FOnButton1down write FOnButton1Down;
    property OnButton1Up: TNotifyEvent read FOnButton1Up write FOnButton1Up;
    property OnButton2Down: TNotifyEvent read FOnButton2down write FOnButton2Down;
    property OnButton2Up: TNotifyEvent read FOnButton2Up write FOnButton2Up;
    property OnButton3Down: TNotifyEvent read FOnButton3down write FOnButton3Down;
    property OnButton3Up: TNotifyEvent read FOnButton3Up write FOnButton3Up;
    property FOnABS_XChange: TNotifyEvent read FFOnABS_XChange write SetFOnABS_XChange;
    property FOnABS_YChange: TNotifyEvent read FFOnABS_YChange write SetFOnABS_YChange;
  end;


procedure register;

implementation

//######################################################################################
procedure register;
begin
 RegisterComponents('RIEvent', [TInputComp_GPS]);
end;
//#######################################################################################

procedure TInputComp_GPS.SetEvData(evdata: TInputData);
begin
 inherited SetEvData(evdata);
 case evdata.evType  of
   1: SetEvent_Type1(evdata);
   3: SetEvent_Type3(evdata);
   end;
end;


procedure TInputComp_GPS.SetFOnABS_XChange(AValue: TNotifyEvent);
begin
  if FFOnABS_XChange=AValue then Exit;
  FFOnABS_XChange:=AValue;
end;

procedure TInputComp_GPS.SetFOnABS_YChange(AValue: TNotifyEvent);
begin
  if FFOnABS_YChange=AValue then Exit;
  FFOnABS_YChange:=AValue;
end;


procedure TInputComp_GPS.SetEvent_Type3(evdata3: TInputData);
   //event keycode
begin
  if evdata3.evcode <> 3 then exit;
   case evdata3.evType of
     {ABS_X}
     0: if assigned(FOnABS_XChange) then FOnABS_XChange(self);
     {ABS_y}
     1: if assigned(FOnABS_yChange) then FOnABS_XChange(self);
     end;
end;

procedure TInputComp_GPS.SetEvent_Type1(evdata1: TInputData);
   //event keycode
begin
   if evdata1.evcode <> 1 then exit;
   case evdata1.evCode of
     {BTN_TRIGGER}
     288:  if evdata1.evValue =1
             then begin
                  ButtonStatus := Buttonstatus or %0001;
                  if assigned(FOnButton0Down) then FOnButton0Down(self);
                  end
             else begin
                  ButtonStatus := Buttonstatus and not %0001;
                  if assigned(FOnButton0Up) then FOnButton0Up(self);
                  end;
     {BTN_THUMB}
     289: if evdata1.evValue =1
             then begin
                  ButtonStatus := Buttonstatus or %0010;
                  if assigned(FOnButton1Down) then FOnButton1Down(self);
                  end
             else begin
                  ButtonStatus := Buttonstatus and not %0010;
                  if assigned(FOnButton1Up) then FOnButton1Up(self);
                  end;
     {BTN_THUMB2}
     290: if evdata1.evValue =1
             then begin
                  ButtonStatus := Buttonstatus or %0100;
                  if assigned(FOnButton2Down) then FOnButton2Down(self);
                  end
             else begin
                  ButtonStatus := Buttonstatus and not %0100;
                  if assigned(FOnButton2Up) then FOnButton2Up(self);
                  end;
     {BTN_TOP}
     291: if evdata1.evValue =1
             then begin
                  ButtonStatus := Buttonstatus or %0100;
                  if assigned(FOnButton3Down) then FOnButton3Down(self);
                  end
             else begin
                  ButtonStatus := Buttonstatus and not %0100;
                  if assigned(FOnButton3Up) then FOnButton3Up(self);
                  end;
     end;
end;


end.

