unit ReadDevInput_VecPedal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ReadDevInput;

type
  TInputComp_VEC = class(TInputComp)
  private
    FOnPedal0Down: TNotifyEvent;
    FOnPedal0Up:   TNotifyEvent;
    FOnPedal1Down: TNotifyEvent;
    FOnPedal1Up:   TNotifyEvent;
    FOnPedal2Down: TNotifyEvent;
    FOnPedal2Up:   TNotifyEvent;
  public
    PedalStatus: byte;
    procedure SetEvData(evdata: TInputData);   override;
  published
    property OnPedal0Down: TNotifyEvent read FOnPedal0down write FOnPedal0Down;
    property OnPedal0Up: TNotifyEvent read FOnPedal0Up write FOnPedal0Up;
    property OnPedal1Down: TNotifyEvent read FOnPedal1down write FOnPedal1Down;
    property OnPedal1Up: TNotifyEvent read FOnPedal1Up write FOnPedal1Up;
    property OnPedal2Down: TNotifyEvent read FOnPedal2down write FOnPedal2Down;
    property OnPedal2Up: TNotifyEvent read FOnPedal2Up write FOnPedal2Up;
  end;


procedure register;

implementation

//######################################################################################
procedure register;
begin
 RegisterComponents('RIEvent', [TInputComp_VEC]);
end;
//#######################################################################################

procedure TInputComp_VEC.SetEvData(evdata: TInputData);
begin
 inherited SetEvData(evdata);
 if evdata.evType = 1
   then   //event keycode
   case evdata.evCode of
     256:  if evdata.evValue =1
             then begin
                  PedalStatus := Pedalstatus or %0001;
                  if assigned(FOnPedal0Down) then FOnPedal0Down(self);
                  end
             else begin
                  PedalStatus := Pedalstatus and not %0001;
                  if assigned(FOnPedal0Up) then FOnPedal0Up(self);
                  end;
     257: if evdata.evValue =1
             then begin
                  PedalStatus := Pedalstatus or %0010;
                  if assigned(FOnPedal1Down) then FOnPedal1Down(self);
                  end
             else begin
                  PedalStatus := Pedalstatus and not %0010;
                  if assigned(FOnPedal1Up) then FOnPedal1Up(self);
                  end;
     258: if evdata.evValue =1
             then begin
                  PedalStatus := Pedalstatus or %0100;
                  if assigned(FOnPedal2Down) then FOnPedal2Down(self);
                  end
             else begin
                  PedalStatus := Pedalstatus and not %0100;
                  if assigned(FOnPedal2Up) then FOnPedal2Up(self);
                  end;
     end;
end;


end.

