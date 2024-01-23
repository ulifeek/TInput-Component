// Important:
//Add User to group 'input': sudo usermod -aG input <username>. Needs reboot to take effect.


unit ReadDevInput;

{$mode objfpc}{$H+}

interface

uses
  cthreads, Classes, SysUtils, FileUtil,dateutils,Dialogs;

type

//TInputData
TInputData = record
 evTimeUnix:int64;
 evTimeMsec:int64;
 evType: word;
 evCode: word;
 evValue: dword;
 end;

//TInputEvent

TInputEvent = procedure (Sender:TObject; time: TDateTime; aType, aCode: word; aValue: dword) of object;

//TEventThread

TInputComp = class;  //forward declaration

TEventThread = class(TThread)
   private
     fInputDeviceFile : string;
     fInputData:TInputData;
     fLog: boolean;
     eventfifo: file of TInputData;
     procedure SendEvent;
     procedure WriteLog(LogString: String);
   protected
     procedure Execute;  override;
   public
   CompIn: TInputComp;
   Constructor Create(CreateSuspended : boolean);
   Destructor Destroy; override;
   end;



//TComponentInputevent

  { TInputComp }

  TInputComp = class(TComponent)

   procedure SetDevice(s:String);
   procedure FindDevice;
  private
    FDevice: string ;
    FEnabled: boolean;
    FEventThread: TEventThread;
    FData: TInputData;
    FLogThread: boolean;
    FOnInputEvent: TInputEvent;
    FEvAsString: string;
    FEvtime: TDateTime;
    FEvtype: word;
    FEvcode: word;
    FEvvalue: dword;
    procedure SetEnabled(aValue: Boolean);
    procedure SetEvAsString(s:String);
    procedure SetOnInputEvent(AValue: TInputEvent);
  public
    constructor create(own:TComponent);   override;
    destructor destroy; override;
    procedure SetEvData(evdata: TInputData);    virtual;
    property enabled: boolean read FEnabled write SetEnabled;
    property eventtime: tDatetime read FEvTime;
    property eventtype: word read FEvtype;
    property eventcode: word read FEvcode;
    property eventvalue: dword read FEvvalue;
  published
    property InputDevice: string read FDevice write SetDevice;
    property LogThread: boolean read FLogThread write FLogThread;
    property OnInputEvent: TInputEvent read FOnInputEvent write SetOnInputEvent;
  end;

procedure register;


implementation


{$R rievent.res}
//######################################################################################
procedure register;
begin
 RegisterComponents('RIEvent', [TInputComp]);
end;
//######################################################################################

constructor TInputComp.create(own: TComponent);
begin
  SetEnabled(false);
  inherited create(own);
end;

destructor TInputComp.destroy;
begin
  if assigned(FEventThread) then FEventThread.Terminate;
  inherited destroy;
end;

procedure TInputComp.SetEvData(evdata: TInputData);
begin
 FData:=evdata;
 FEvtime:= IncMilliSecond(UnixToDateTime(evdata.evTimeUnix),evdata.evTimeMsec div 1000);
 FEvtype:=evdata.evType;
 FEvcode:=evdata.evCode;
 FEvvalue:=evdata.evValue;
 SetEvAsString(DateTimeToStr(FEvTime) + ' | ' +  inttostr(evdata.evType) + ' | ' + inttostr(evdata.evCode) + ' | ' + inttostr(evdata.evValue));
 if assigned(FOnInputEvent) then FOnInputEvent(self, FEvtime, FEvtype, FEvcode, FEvvalue);
end;

procedure TInputComp.SetEvAsString(s: String);
begin
  FEvAsString := s;
end;

procedure TInputComp.SetOnInputEvent(AValue: TInputEvent);
begin
  if FOnInputEvent=AValue then Exit;
  FOnInputEvent:=AValue;
end;

procedure TInputComp.SetEnabled(aValue: Boolean);
begin
FEnabled := aValue;
if FEnabled
  then begin
         FEventThread := TEventThread.create(true);
         FEventThread.CompIn := self;
         FEventThread.fInputDeviceFile := self.FDevice;
         FEventThread.fLog:= self.FLogThread;
         FEventThread.Start();
         end;
if not FEnabled  and assigned(FEventThread)
  then begin
         FEventThread.terminate;
       end;
end;

procedure TInputComp.FindDevice;
var opendialog1: Topendialog;
begin
Opendialog1 := TOpenDialog.Create(self);
with OpenDialog1 do
  begin
  initialdir:='/dev/input/by-id/';
  title:= 'Select Event-File';
  options:=  [ofNoChangeDir,ofExtensionDifferent,ofFileMustExist,ofNoNetworkButton,ofOldStyleDialog,ofEnableSizing,ofViewDetail,ofNoDereferenceLinks,ofNoResolveLinks];
  if Execute then setDevice(filename) else showmessage('Error. Has user read permission to selected file? Check your rules please.')
  end;
opendialog1.free;;
end;


procedure TInputComp.SetDevice(s: String);
begin
  if fileexists(s) then FDevice := s else showmessage('EventInputfile does not exist: '+s);
end;

//########################################################################################################################################
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Thread xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//########################################################################################################################################

Constructor TEventThread.Create(CreateSuspended : boolean);
begin
  inherited create(CreateSuspended);
  FreeOnTerminate := True;
  writelog('Thread created: Eventthread');
end;

Destructor TEventThread.Destroy;
begin
 Reset(eventfifo);
 if IOResult <> 0 then closefile(eventfifo);
 writelog('Thread destroyeded: Eventthread');
 inherited destroy;
end;

procedure TEventThread.SendEvent;
begin
 self.CompIn.SetEvData(fInputData);
end;


procedure TEventThread.WriteLog(LogString: String);
var
   f: TextFile;
 begin
 if flog then
   begin
   AssignFile(f, ExtractFilePath(ParamStr(0))+'InputCompThread.log');
   if FileExists(ExtractFilePath(ParamStr(0))+'InputCompThread.log') then
     Append(f)
   else
   Rewrite(f);
   Writeln(f, Datetostr(date) +' '+ timetostr(time) +':   '+LogString);
   CloseFile(f);
   end;
end;

procedure TEventThread.Execute;
begin
   writelog ('EventThread started');
   filemode:=0;
   if fileexists(self.fInputDeviceFile) then
     begin
       Assignfile(eventfifo,fInputDeviceFile);
       reset(eventfifo);
       writelog('Deviceinputfile opened: ' +  self.fInputDeviceFile);
       while (not Terminated) do
          try
            begin
            read(eventfifo, fInputData);
            writelog('Got event (type-code-value): ' +inttostr(fInputData.evType)+'-'+inttostr(fInputData.evCode)+'-'+inttostr(fInputData.evValue));
            synchronize(@SendEvent);
            end;
          except
          end;
      CloseFile(eventfifo);
      writelog('Deviceinputfile closed: ' +  self.fInputDeviceFile);
     end;
 end;

end.

