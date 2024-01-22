unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ReadDevInputComp_Keyboard,inifiles, ReadDevInput;

type

  { TForm1 }

  TForm1 = class(TForm)
    InputComp_Keyboard1: TInputComp_Keyboard;
    InputComp_Keyboard2: TInputComp_Keyboard;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure InputComp_Keyboard1FOnMSCChange(Sender: TObject; avalue: Longword
      );
    procedure InputComp_Keyboard1KeyDown(Sender: TObject; scancode: byte);
    procedure InputComp_Keyboard1KeyRepeat(Sender: TObject; scancode: byte);
    procedure InputComp_Keyboard1KeyUp(Sender: TObject; scancode: byte);
  private
    function GetInputDevice: string;
    procedure SetInputDevice(device: string);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);

begin
 if fileexists(InputComp_Keyboard1.InputDevice)  // Inputdevice aus Propertyeditor
    then InputComp_Keyboard1.enabled:=true
    else begin
          InputComp_Keyboard1.InputDevice:= GetInputDevice;               //Inputdevice aus Inifile
          if fileexists(InputComp_Keyboard1.InputDevice)
             then InputComp_Keyboard1.enabled:=true
             else begin
                    InputComp_Keyboard1.FindDevice;
                    SetInputDevice(InputComp_Keyboard1.InputDevice);
                    InputComp_Keyboard1.enabled:=true;
                  end;
          end;
end;

procedure TForm1.InputComp_Keyboard1FOnMSCChange(Sender: TObject;
  avalue: Longword);
begin
   Listbox2.Items.Insert(0, 'MSC_Code: ' + Inttohex(avalue));
   Listbox2.TopIndex:=0;
end;

procedure TForm1.InputComp_Keyboard1KeyDown(Sender: TObject; scancode: byte);
begin
 Listbox1.Items.Insert(0, 'Key Down: ' + Inttostr(scancode));
 Listbox1.TopIndex:=0;
end;

procedure TForm1.InputComp_Keyboard1KeyRepeat(Sender: TObject; scancode: byte);
begin
 Listbox1.Items.Insert(0, 'Key Repeat: ' + Inttostr(scancode));
 Listbox1.TopIndex:=0;
end;

procedure TForm1.InputComp_Keyboard1KeyUp(Sender: TObject; scancode: byte);
begin
 Listbox1.Items.Insert(0, 'Key UP: ' + Inttostr(scancode));
 Listbox1.TopIndex:=0;
end;

function TForm1.GetInputDevice: string;
begin
  with Tinifile.create(ChangeFileExt(Application.exename, '.ini')) do
    begin
      result:=ReadString('Device','Filename','');
    end;
  if not FileExists(result) then result :='';
end;

procedure TForm1.SetInputDevice(device: string);
begin
  with Tinifile.create(ChangeFileExt(Application.exename, '.ini')) do
    begin
      WriteString('Device','Filename', device);
    end;
end;





end.

