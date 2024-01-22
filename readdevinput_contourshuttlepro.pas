unit ReadDevInput_ContourShuttlePro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ReadDevInput;

type
  TWheelpos= -7..7;
  TContourDialEvent = procedure (Sender:TObject; Dialposition: byte) of object;
  TContourWheelEvent = procedure (Sender:TObject; WheelPosition: TWheelpos) of object;
  TContourWheel_High_ResEvent = procedure (Sender:TObject; Wheelpos_High_Res: integer) of Object;
  TContourButtonDownEvent = procedure (Sender:TObject; Button: integer) of object;
  TContourButtonUpEvent = procedure (Sender:TObject; Button: integer) of object;
  TContourStatusChangedEvent = procedure (Sender:TObject; Buttons: word; DialPos: byte; WheelPos: TWheelpos; WhhelPos_High_Res: integer) of Object;
  { TInputComp_CSP }

  TInputComp_CSP = class(TInputComp)
  private
    FOnButton0down: TNotifyEvent;
    FOnButton0Up:   TNotifyEvent;
    FOnButton1Down: TNotifyEvent;
    FOnButton1Up:   TNotifyEvent;
    FOnButton2Down: TNotifyEvent;
    FOnButton2Up:   TNotifyEvent;
    FOnButton3Down: TNotifyEvent;
    FOnButton3Up:   TNotifyEvent;
    FOnButton4Down: TNotifyEvent;
    FOnButton4Up:   TNotifyEvent;
    FOnButton5Down: TNotifyEvent;
    FOnButton5Up:   TNotifyEvent;
    FOnButton6Down: TNotifyEvent;
    FOnButton6Up:   TNotifyEvent;
    FOnButton7Down: TNotifyEvent;
    FOnButton7Up:   TNotifyEvent;
    FOnButton8Down: TNotifyEvent;
    FOnButton8Up:   TNotifyEvent;
    FOnButton9Down: TNotifyEvent;
    FOnButton9Up:   TNotifyEvent;
    FOnButton10Down: TNotifyEvent;
    FOnButton10Up:   TNotifyEvent;
    FOnButton11Down: TNotifyEvent;
    FOnButton11Up:   TNotifyEvent;
    FOnButton12Down: TNotifyEvent;
    FOnButton12Up:   TNotifyEvent;
    FOnButton13Down: TNotifyEvent;
    FOnButton13Up:   TNotifyEvent;
    FOnButton14Down: TNotifyEvent;
    FOnButton14Up:   TNotifyEvent;
    FOnButtonDown: TContourButtonDownEvent;
    FOnButtonUp: TContourButtonUpEvent;
    FOnStatusChanged: TContourStatusChangedEvent;
    FOnWheelChange: TContourWheelEvent;
    FOnWheel_High_ResChange: TContourWheel_High_ResEvent;
    FonDialChange: TContourDialEvent;
    FPositionDial: byte;
    FPositionWheel: TWheelpos;
    FPositionHighResWheel: integer;
    FButtonStatus: word;
    procedure SetEvent_Type1(evdata1: TInputData);
    procedure SetEvent_Type2(evdata2: TInputData);
    procedure SetOnButtonDown(AValue: TContourButtonDownEvent);
    procedure SetOnButtonUp(AValue: TContourButtonUpEvent);
    procedure SetonDialChange(AValue: TContourDialEvent);
    procedure SetOnStatusChanged(AValue: TContourStatusChangedEvent);
    procedure SetOnWheelChange(AValue: TContourWheelEvent);
    procedure SetOnWheel_High_ResChange(AValue: TContourWheel_High_ResEvent);
    procedure SetPositionDial(AValue: byte);
    procedure SetPositionWheel(AValue: TWheelpos);
    procedure SetPositionHighResWheel(AValue: integer);
    procedure StatusChanged;

  public
    Constructor Create(Own: TComponent);
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
    property OnButton4Down: TNotifyEvent read FOnButton4down write FOnButton4Down;
    property OnButton4Up: TNotifyEvent read FOnButton4Up write FOnButton4Up;
    property OnButton5Down: TNotifyEvent read FOnButton5down write FOnButton5Down;
    property OnButton5Up: TNotifyEvent read FOnButton5Up write FOnButton5Up;
    property OnButton6Down: TNotifyEvent read FOnButton6down write FOnButton6Down;
    property OnButton6Up: TNotifyEvent read FOnButton6Up write FOnButton6Up;
    property OnButton7Down: TNotifyEvent read FOnButton7down write FOnButton7Down;
    property OnButton7Up: TNotifyEvent read FOnButton7Up write FOnButton7Up;
    property OnButton8Down: TNotifyEvent read FOnButton8down write FOnButton8Down;
    property OnButton8Up: TNotifyEvent read FOnButton8Up write FOnButton8Up;
    property OnButton9Down: TNotifyEvent read FOnButton9down write FOnButton9Down;
    property OnButton9Up: TNotifyEvent read FOnButton9Up write FOnButton9Up;
    property OnButton10Down: TNotifyEvent read FOnButton10down write FOnButton10Down;
    property OnButton10Up: TNotifyEvent read FOnButton10Up write FOnButton10Up;
    property OnButton11Down: TNotifyEvent read FOnButton11down write FOnButton11Down;
    property OnButton11Up: TNotifyEvent read FOnButton11Up write FOnButton11Up;
    property OnButton12Down: TNotifyEvent read FOnButton12down write FOnButton12Down;
    property OnButton12Up: TNotifyEvent read FOnButton12Up write FOnButton12Up;
    property OnButton13Down: TNotifyEvent read FOnButton13down write FOnButton13Down;
    property OnButton13Up: TNotifyEvent read FOnButton13Up write FOnButton13Up;
    property OnButton14Down: TNotifyEvent read FOnButton14down write FOnButton14Down;
    property OnButton14Up: TNotifyEvent read FOnButton14Up write FOnButton14Up;
    property OnWheelChange: TContourWheelEvent read FOnWheelChange write SetOnWheelChange;
    property OnWheel_High_ResChange: TContourWheel_High_ResEvent read FOnWheel_High_ResChange write SetOnWheel_High_ResChange;
    property OnDialChange: TContourDialEvent read FonDialChange write SetonDialChange;
    property PositionDial: byte read FPositionDial write SetPositionDial;
    property PositionWheel: TWheelpos read FPositionWheel write SetPositionWheel;
    property PositionHighResWheel: integer read FPositionHighResWheel write SetPositionHighResWheel;
    property OnButtonDown: TContourButtonDownEvent read FOnButtonDown write SetOnButtonDown;
    property OnButtonUp: TContourButtonUpEvent read FOnButtonUp write SetOnButtonUp;
    Property OnStatusChanged: TContourStatusChangedEvent read FOnStatusChanged write SetOnStatusChanged;
  end;


procedure register;

implementation

//######################################################################################
procedure register;
begin
 RegisterComponents('RIEvent', [TInputComp_CSP]);
end;
//#######################################################################################

procedure TInputComp_CSP.SetEvData(evdata: TInputData);
begin
 inherited SetEvData(evdata);
 case evdata.evType  of
   1: SetEvent_Type1(evdata);
   2: SetEvent_Type2(evdata);
   end;
end;

procedure TInputComp_CSP.SetEvent_Type1(evdata1: TInputData);
begin
   if evdata1.evType <> 1 then exit;
   //event keycode
   case evdata1.evCode of
     256:  if evdata1.evValue = 1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000000001;
                  if assigned(FOnButton0Down) then FOnButton0Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000000001;
                  if assigned(FOnButton0Up) then FOnButton0Up(self);
                  end;
     257: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000000010;
                  if assigned(FOnButton1Down) then FOnButton1Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000000010;
                  if assigned(FOnButton1Up) then FOnButton1Up(self);
                  end;
     258: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000000100;
                  if assigned(FOnButton2Down) then FOnButton2Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000000100;
                  if assigned(FOnButton2Up) then FOnButton2Up(self);
                  end;
     259: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000001000;
                  if assigned(FOnButton3Down) then FOnButton3Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000001000;
                  if assigned(FOnButton3Up) then FOnButton3Up(self);
                  end;
     260: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000010000;
                  if assigned(FOnButton4Down) then FOnButton4Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000010000;
                  if assigned(FOnButton4Up) then FOnButton4Up(self);
                  end;
     261: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000000100000;
                  if assigned(FOnButton5Down) then FOnButton5Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000000100000;
                  if assigned(FOnButton5Up) then FOnButton5Up(self);
                  end;
     262: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000001000000;
                  if assigned(FOnButton6Down) then FOnButton6Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000001000000;
                  if assigned(FOnButton6Up) then FOnButton6Up(self);
                  end;
     263: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000010000000;
                  if assigned(FOnButton7Down) then FOnButton7Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000010000000;
                  if assigned(FOnButton7Up) then FOnButton7Up(self);
                  end;
     264: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000000100000000;
                  if assigned(FOnButton8Down) then FOnButton8Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000000100000000;
                  if assigned(FOnButton8Up) then FOnButton8Up(self);
                  end;
     265: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000001000000000;
                  if assigned(FOnButton9Down) then FOnButton9Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000001000000000;
                  if assigned(FOnButton9Up) then FOnButton9Up(self);
                  end;
     266: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000010000000000;
                  if assigned(FOnButton10Down) then FOnButton10Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000010000000000;
                  if assigned(FOnButton10Up) then FOnButton10Up(self);
                  end;
     267: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0000100000000000;
                  if assigned(FOnButton11Down) then FOnButton11Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0000100000000000;
                  if assigned(FOnButton11Up) then FOnButton11Up(self);
                  end;
     268: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0001000000000000;
                  if assigned(FOnButton12Down) then FOnButton12Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0001000000000000;
                  if assigned(FOnButton12Up) then FOnButton12Up(self);
                  end;
     269: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0010000000000000;
                  if assigned(FOnButton13Down) then FOnButton13Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0010000000000000;
                  if assigned(FOnButton13Up) then FOnButton13Up(self);
                  end;
     270: if evdata1.evValue =1
             then begin
                  FButtonStatus := FButtonStatus or %0100000000000000;
                  if assigned(FOnButton14Down) then FOnButton14Down(self);
                  end
             else begin
                  FButtonStatus := FButtonStatus and not %0100000000000000;
                  if assigned(FOnButton14Up) then FOnButton14Up(self);
                  end;
     end;
   if evdata1.evvalue = 1 then FOnButtonDown(self,evdata1.evcode-256);
   if evdata1.evvalue = 0 then FOnButtonUp(self,evdata1.evcode-256);
   StatusChanged;
end;

procedure TInputComp_CSP.SetEvent_Type2(evdata2: TInputData);
begin
   if evdata2.evType <> 2 then exit;
   case evdata2.evCode of
      7 {dial}          : PositionDial:=evdata2.evValue;
      8 {wheel}         : PositionWheel:=evdata2.evValue;
     11 {wheel_high_res}: PositionHighResWheel:=evdata2.evValue;
     end;
end;

procedure TInputComp_CSP.SetOnButtonDown(AValue: TContourButtonDownEvent);
begin
  if FOnButtonDown=AValue then Exit;
  FOnButtonDown:=AValue;
end;

procedure TInputComp_CSP.SetOnButtonUp(AValue: TContourButtonUpEvent);
begin
  if FOnButtonUp=AValue then Exit;
  FOnButtonUp:=AValue;
end;

procedure TInputComp_CSP.SetonDialChange(AValue: TContourDialEvent);
begin
  if FonDialChange=AValue then Exit;
  FonDialChange:=AValue;
end;

procedure TInputComp_CSP.SetOnStatusChanged(AValue: TContourStatusChangedEvent);
begin
  if FOnStatusChanged=AValue then Exit;
  FOnStatusChanged:=AValue;
end;

procedure TInputComp_CSP.SetOnWheelChange(AValue: TContourWheelEvent);
begin
  if FOnWheelChange=AValue then Exit;
  FOnWheelChange:=AValue;
end;

procedure TInputComp_CSP.SetOnWheel_High_ResChange(
  AValue: TContourWheel_High_ResEvent);
begin
  if FOnWheel_High_ResChange=AValue then Exit;
  FOnWheel_High_ResChange:=AValue;
end;

procedure TInputComp_CSP.SetPositionDial(AValue: byte);
begin
  if FPositionDial=AValue then Exit;
  FPositionDial:=AValue;
  if assigned(FonDialChange) then FonDialChange(self,aValue);
  StatusChanged;
end;

procedure TInputComp_CSP.SetPositionWheel(AValue: TWheelpos);
begin
  if FPositionWheel=AValue then Exit;
  FPositionWheel:=AValue;
  if assigned(FOnWheelChange) then FOnWheelChange(self, aValue);
  StatusChanged;
end;

procedure TInputComp_CSP.SetPositionHighResWheel(AValue: integer);
begin
  if FPositionHighResWheel=AValue then Exit;
  FPositionHighResWheel:=AValue;
  if assigned(FOnWheel_High_ResChange) then FOnWheel_High_ResChange(self, aValue);
  StatusChanged;
end;

procedure TInputComp_CSP.StatusChanged;
begin
 if assigned(FOnStatusChanged) then FOnStatusChanged(self,FButtonStatus,FPositionDial, FPositionWheel, FPositionHighResWheel);
end;

constructor TInputComp_CSP.Create(Own: TComponent);
begin
  inherited Create(Own);
  FButtonStatus:=0;
  FPositionDial:=0;
  FPositionWheel:=0;
  FPositionHighResWheel:=0;
end;

end.


{###############################################################################
Output of evtest:

/dev/input/event20:     Contour Design ShuttlePRO v2
Select the device event number [0-20]: 20
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xb33 product 0x30 version 0x110
Input device name: "Contour Design ShuttlePRO v2"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 256 (BTN_0)
    Event code 257 (BTN_1)
    Event code 258 (BTN_2)
    Event code 259 (BTN_3)
    Event code 260 (BTN_4)
    Event code 261 (BTN_5)
    Event code 262 (BTN_6)
    Event code 263 (BTN_7)
    Event code 264 (BTN_8)
    Event code 265 (BTN_9)
    Event code 266 (?)
    Event code 267 (?)
    Event code 268 (?)
    Event code 269 (?)
    Event code 270 (?)
  Event type 2 (EV_REL)
    Event code 7 (REL_DIAL)
    Event code 8 (REL_WHEEL)
    Event code 11 (REL_WHEEL_HI_RES)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_

}
