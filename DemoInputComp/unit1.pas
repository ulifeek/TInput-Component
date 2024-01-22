unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, ReadDevInput, fileutil;

type

  { TForm1 }

  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    InputComp1: TInputComp;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    ListBox1: TListBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InputComp1InputEvent(Sender: TObject; time: TDateTime; aType,
      aCode: word; aValue: dword);
  private

  public

  end;

var
  Form1: TForm1;
  DeviceDir:  string = '/dev/input/by-id/';

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Combobox1.items:=FindAllFiles(DeviceDir,'*',false);
  Combobox1.ItemIndex:=0;
end;

procedure TForm1.InputComp1InputEvent(Sender: TObject; time: TDateTime; aType,
  aCode: word; aValue: dword);
var sTime,sType,sCode, sValue: string;
begin
 if CheckBox1.checked then if aType<>UpDown1.Position then exit;
 if CheckBox2.checked then if aCode<>UpDown2.Position then exit;
 if CheckBox3.checked then if aValue<>UpDown3.Position then exit;
 sTime:='Time: '+ DateTimeToStr(time) +'  |  ';
 sType:='Type: '+ inttostr(atype) +'  |  ';
 sCode:='Code: '+ inttostr(aCode) +'  |  ';
 sValue:='Value '+ inttostr(aValue) +'  |  ';
 Listbox1.items.insert(0,sTime+sType+sCode+sValue);
 Listbox1.TopIndex:=0;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 InputComp1.InputDevice:=combobox1.Text;
 InputComp1.enabled:=true;
end;

end.

