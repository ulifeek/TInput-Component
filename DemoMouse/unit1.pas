unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ReadDevInputComp_Keyboard,inifiles, ReadDevInput, ReadDevInputComp_Mouse;

type

  { TForm1 }

  TForm1 = class(TForm)
    InputComp_Mouse1: TInputComp_Mouse;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure InputComp_Mouse1ButtonDown(Sender: TObject; aValue: integer);
    procedure InputComp_Mouse1ButtonUp(Sender: TObject; aValue: integer);
    procedure InputComp_Mouse1Wheel(Sender: TObject; aValue: integer);
    procedure InputComp_Mouse1XChange(Sender: TObject; aValue: integer);
    procedure InputComp_Mouse1YChange(Sender: TObject; aValue: integer);
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
 if fileexists(InputComp_Mouse1.InputDevice)  // Inputdevice aus Propertyeditor
    then InputComp_Mouse1.enabled:=true
    else begin
          InputComp_Mouse1.InputDevice:= GetInputDevice;               //Inputdevice aus Inifile
          if fileexists(InputComp_Mouse1.InputDevice)
             then InputComp_Mouse1.enabled:=true
             else begin
                    InputComp_Mouse1.FindDevice;
                    SetInputDevice(InputComp_Mouse1.InputDevice);
                    InputComp_Mouse1.enabled:=true;
                  end;
          end;
end;


procedure TForm1.InputComp_Mouse1ButtonDown(Sender: TObject; aValue: integer);
begin
 Listbox1.Items.Insert(0, 'Button Down: ' + Inttostr(aValue));
 Listbox1.TopIndex:=0;
end;

procedure TForm1.InputComp_Mouse1ButtonUp(Sender: TObject; aValue: integer);
begin
 Listbox1.Items.Insert(0, 'Button UP: ' + Inttostr(aValue));
 Listbox1.TopIndex:=0;
end;

procedure TForm1.InputComp_Mouse1Wheel(Sender: TObject; aValue: integer);
begin
 Listbox2.Items.Insert(0, 'Wheel: ' + Inttostr(aValue));
 Listbox2.TopIndex:=0;
end;

procedure TForm1.InputComp_Mouse1XChange(Sender: TObject; aValue: integer);
begin
 Listbox2.Items.Insert(0, 'Rel_X: ' + Inttostr(aValue));
 Listbox2.TopIndex:=0;
end;

procedure TForm1.InputComp_Mouse1YChange(Sender: TObject; aValue: integer);
begin
 Listbox2.Items.Insert(0, 'Rel_Y: ' + Inttostr(aValue));
 Listbox2.TopIndex:=0;
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

