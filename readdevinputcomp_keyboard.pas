unit ReadDevInputComp_Keyboard;

{Note: Made for demo purposes only, there is no practical use as Keyboard events are fully supported by X-Server and Lazarus}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ReadDevInput;

type

  TKeyboardEvent = procedure (Sender:TObject; scancode: byte) of object;
  TKeyboardMSCEvent = procedure (Sender:TObject; avalue:Longword) of object;


  { TInputComp_Mouse }

  { TInputComp_Keyboard }

  TInputComp_Keyboard = class(TInputComp)
    private
      FOnKeyDown: TKeyboardEvent;
      FOnKeyMSC: TKeyboardMSCEvent;
      FOnKeyRepeat: TKeyboardEvent;
      FOnKeyUp: TKeyboardEvent;
      procedure SetOnKeyDown(AValue: TKeyboardEvent);
      procedure SetOnKeyMSC(AValue: TKeyboardMSCEvent);
      procedure SetOnKeyRepeat(AValue: TKeyboardEvent);
      procedure SetOnKeyUp(AValue: TKeyboardEvent);

  public
    procedure SetEvData(evdata: TInputData); override;
  published
    property OnKeyDown:TKeyboardEvent read FOnKeyDown write SetOnKeyDown;
    property OnKeyUp: TKeyboardEvent read FOnKeyUp write SetOnKeyUp;
    property OnKeyRepeat: TKeyboardEvent read FOnKeyRepeat write SetOnKeyRepeat;
    property FOnMSCChange: TKeyboardMSCEvent read FOnKeyMSC write SetOnKeyMSC;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RIEvent',[TInputComp_Keyboard]);
end;

procedure TInputComp_Keyboard.SetOnKeyDown(AValue: TKeyboardEvent);
begin
  if FOnKeyDown=AValue then Exit;
  FOnKeyDown:=AValue;
end;

procedure TInputComp_Keyboard.SetOnKeyMSC(AValue: TKeyboardMSCEvent);
begin
  if FOnKeyMSC=AValue then Exit;
  FOnKeyMSC:=AValue;
end;

procedure TInputComp_Keyboard.SetOnKeyRepeat(AValue: TKeyboardEvent);
begin
  if FOnKeyRepeat=AValue then Exit;
  FOnKeyRepeat:=AValue;
end;

procedure TInputComp_Keyboard.SetOnKeyUp(AValue: TKeyboardEvent);
begin
  if FOnKeyUp=AValue then Exit;
  FOnKeyUp:=AValue;
end;

procedure TInputComp_Keyboard.SetEvData(evdata: TInputData);
begin
 inherited SetEvData(evdata);
 case evdata.evType of
   1: begin
        if evdata.evvalue = 1 then
          if assigned(FOnKeyDown) then FOnKeyDown(self,evdata.evcode);
        if evdata.evvalue = 0 then
          if assigned(FOnKeyUp) then FOnKeyUp(self,evdata.evcode);
        if evdata.evvalue = 2 then
          if assigned(FOnKeyRepeat) then FOnKeyRepeat(self,evdata.evcode);
      end;
   4: begin
        if evdata.evcode = 4 {MSC_Scan} then
          if assigned(FOnMSCChange) then FOnMSCChange(self, evdata.evValue);
      end;
  end;
end;


end.
