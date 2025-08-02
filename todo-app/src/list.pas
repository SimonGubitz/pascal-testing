unit List;

interface

uses
    Types, Globals, Utils;

function ShowLists: Boolean;
procedure AddList(newList: TList);



implementation

// returns false if empty
function ShowLists: Boolean;
var
    i: Integer;
    lists: array of TList;
begin

    WriteLn('These are your Lists:');
    lists := Lists;


    if Length(Lists) >= 1 then
    begin
        for i := 0 to Length(Lists) - 1 do
        begin
            WriteLn('# ', i + 1, '   ', Lists[i].ListName, '    ', Lists[i].ListDescription);
        end;
        Result := true;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'You currently have no Lists.' + #27'[0m');
        Result := false;
    end;
end;

procedure AddList(newList: TList);
begin
    SetLength(Lists, Length(Lists) + 1);
    Lists[Length(Lists)-1] := newList;
end;


end.