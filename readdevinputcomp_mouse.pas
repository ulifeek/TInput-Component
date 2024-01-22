unit ReadDevInputComp_Mouse;
{Note: Made for demo purposes only, there is no use as mouse events are fully supported by X-Server and Lazarus}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ReadDevInput;

type

  TMouseEvent = procedure (Sender:TObject; aValue: integer) of object;


  { TInputComp_Mouse }

  TInputComp_Mouse = class(TInputComp)
    private
      FOnButtonDown: TMouseEvent;
      FOnButtonUp: TMouseEvent;
      FOnWheel: TMouseEvent;
      FOnXChange: TMouseEvent;
      FOnYChange: TMouseEvent;
      procedure SetOnButtonDown(AValue: TMouseEvent);
      procedure SetOnButtonUp(AValue: TMouseEvent);
      procedure SetOnWheel(AValue: TMouseEvent);
      procedure SetOnXChange(AValue: TMouseEvent);
      procedure SetOnYChange(AValue: TMouseEvent);

  public
    procedure SetEvData(evdata: TInputData);   override;
  published
    property OnButtonDown:TMouseEvent read FOnButtonDown write SetOnButtonDown;
    property OnButtonUp: TMouseEvent read FOnButtonUp write SetOnButtonUp;
    property OnWheel: TMouseEvent read FOnWheel write SetOnWheel;
    property OnXChange: TMouseEvent read FOnXChange write SetOnXChange;
    property OnYChange: TMouseEvent read FOnYChange write SetOnYChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RIEvent',[TInputComp_Mouse]);
end;

procedure TInputComp_Mouse.SetOnButtonDown(AValue: TMouseEvent);
begin
  if FOnButtonDown=AValue then Exit;
  FOnButtonDown:=AValue;
end;

procedure TInputComp_Mouse.SetOnButtonUp(AValue: TMouseEvent);
begin
  if FOnButtonUp=AValue then Exit;
  FOnButtonUp:=AValue;
end;

procedure TInputComp_Mouse.SetOnWheel(AValue: TMouseEvent);
begin
  if FOnWheel=AValue then Exit;
  FOnWheel:=AValue;
end;

procedure TInputComp_Mouse.SetOnXChange(AValue: TMouseEvent);
begin
  if FOnXChange=AValue then Exit;
  FOnXChange:=AValue;
end;

procedure TInputComp_Mouse.SetOnYChange(AValue: TMouseEvent);
begin
  if FOnYChange=AValue then Exit;
  FOnYChange:=AValue;
end;

procedure TInputComp_Mouse.SetEvData(evdata: TInputData);
begin
 inherited SetEvData(evdata);
 case evdata.evType of
   1: begin
        if evdata.evvalue = 1 then
          if assigned(FOnButtonDown) then FOnButtonDown(self,evdata.evcode-272);
        if evdata.evvalue = 0 then
          if assigned(FOnButtonUp) then FOnButtonUp(self,evdata.evcode-272);
      end;
   2: begin
        if evdata.evcode = 0 {Rel_X} then
          if assigned(FOnXChange) then FOnXChange(self, evdata.evValue);
        if evdata.evcode = 1 {Rel_Y} then
          if assigned(FOnYChange) then FOnYChange(self, evdata.evValue);
        if evdata.evcode = 8 {Rel_Wheel} then
          if assigned(FOnWheel) then FOnWheel(self, evdata.evValue);
      end;
  end;
end;


end.
