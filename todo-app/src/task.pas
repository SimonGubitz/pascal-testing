unit Task;

interface

uses
    SysUtils, List, Types, Globals, Utils;

function ShowTasks(ListIndex: Integer): Boolean;
procedure RemoveTask(ListIndex: Integer; TaskIndex: Integer);
procedure AddTask(var ListIndex: Integer; ListEntity: TListEntity);



implementation

// returns false if empty
function ShowTasks(ListIndex: Integer): Boolean;
var
    i: Integer;
    list: TList;
    tickedChar: string;
begin

    ClearTerminal;

    WriteLn('These are your Tasks:');

    list := Lists[ListIndex]; // is be safe due to previous checking if that list exists

    if Length(list.ListEntities) >= 1 then
    begin
        for i := 0 to Length(list.ListEntities) - 1 do
        begin

            tickedChar := 'y/n';
            // tickedChar := '✓';
            // if list.ListEntities[i].EntityTicked = false then tickedChar := '☐';

            WriteLn('# ', i + 1, ' ' + tickedChar, '     ', list.ListEntities[i].EntityText + '    ' + DateTimeToStr(list.ListEntities[i].EntityDate));

        end;
        Result := true;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'You currently have no tasks.' + #27'[0m');
        Result := false;
    end;

end;

procedure RemoveTask(ListIndex: Integer; TaskIndex: Integer);
var
    UpdatedList: array of TListEntity;
    i, NewIndex: Integer;
begin

    NewIndex := 0;
    SetLength(UpdatedList, Length(Lists[ListIndex].ListEntities) - 1);

    for i := 0 to Length(Lists[ListIndex].ListEntities) - 1 do
    begin
        if i <> TaskIndex then
        begin
            UpdatedList[NewIndex] := Lists[listIndex].ListEntities[i];
            Inc(NewIndex);
        end;
    end;

    Lists[ListIndex].ListEntities := UpdatedList;

end;

procedure AddTask(var ListIndex: Integer; ListEntity: TListEntity);
var
    EntitiesLength: Integer;
begin
    EntitiesLength := Length(Lists[ListIndex].ListEntities);

    SetLength(Lists[ListIndex].ListEntities, EntitiesLength + 1);

    Lists[listIndex].ListEntities[EntitiesLength] := ListEntity;

end;


end.