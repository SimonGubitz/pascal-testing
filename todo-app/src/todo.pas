program TodoApp;

uses
    SysUtils, Crt, Utils;

type TListEntity = record
    EntityTicked: Boolean;
    EntityText: string;
    EntityDate: TDateTime;
end;

type TList = record
    ListName: string;
    ListDescription: string;
    ListEntities: array of TListEntity;
end;

var lists: array of TList;
var UserInput: string;



function ShowLists: Boolean; forward;
procedure InputShowLists; forward;
procedure InputDrawHomepage; forward;

// Writes into Global "UserInput"
procedure DrawOptions(Options: array of string);
var
    i: Integer;
begin
    WriteLn(#27 + '[34m', 'Options:' +  #27'[0m');
    for i := 0 to Length(options) -1 do
    begin
        WriteLn('# ', i + 1, '     ', options[i]);
    end;
    Write('Enter your selection: ');
    ReadLn(UserInput);
end;

// returns false if empty
function ShowTasks(ListIndex: Integer): Boolean;
var
    i: Integer;
    list: TList;
    tickedChar: string;
begin

    ClearTerminal;

    WriteLn('These are your Lists:');

    list := lists[ListIndex]; // is be safe due to previous checking if that list exists

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
    SetLength(UpdatedList, Length(lists[ListIndex].ListEntities) - 1);

    for i := 0 to Length(lists[ListIndex].ListEntities) - 1 do
    begin
        if i <> TaskIndex then
        begin
            UpdatedList[NewIndex] := lists[listIndex].ListEntities[i];
            Inc(NewIndex);
        end;
    end;

    lists[ListIndex].ListEntities := UpdatedList;

end;

procedure InputRemoveTask(ListIndex: Integer);
var
    TaskIndex: Integer;
begin

    ClearTerminal;

    Write('Which Task do you want to remove? Enter index: ');
    ReadLn(UserInput);

    TaskIndex := Atoi(UserInput) - 1;

    WriteLn('TaskIndex: ', TaskIndex);

    if ValidateUserInput(UserInput) then
    begin
        if TaskIndex > Length(lists[ListIndex].ListEntities) then
        begin
            InvalidInput();
            InputDrawHomepage;
        end
        else
        begin
            RemoveTask(ListIndex, TaskIndex);
            InputShowLists;
        end;
    end;

end;

procedure AddTask(var ListIndex: Integer; ListEntity: TListEntity);
var
    EntitiesLength: Integer;
begin
    EntitiesLength := Length(lists[ListIndex].ListEntities);

    SetLength(lists[ListIndex].ListEntities, EntitiesLength + 1);

    lists[listIndex].ListEntities[EntitiesLength] := ListEntity;

end;

procedure InputAddTask(listIndex: Integer);
var
    taskText: string;
    dateInputDecision: string;
    taskDate: TDateTime;
    newTask: TListEntity;
    options: array of string;
begin

    ClearTerminal;

    WriteLn('What should be the Name of the Task?');
    ReadLn(taskText);

    WriteLn('What should be the Date? (Now/Custom)');
    ReadLn(dateInputDecision);

    taskDate := Now;

    if dateInputDecision = 'Custom' then
    begin
        taskDate := CustomDateInput();
    end
    else if dateInputDecision <> 'Now' then
    begin
        InvalidInput();
        InputDrawHomepage;
    end;


    newTask.EntityTicked := false;
    newTask.EntityText := taskText;
    newTask.EntityDate := taskDate;

    AddTask(listIndex, newTask);
    ShowTasks(listIndex);


    DrawEmptyLines(2);

    SetLength(options, 3);
    options[0] := 'Add another Task';
    options[1] := 'View all Lists';
    options[2] := 'Go back Home';
    DrawOptions(options);

    if ValidateUserInput(UserInput) then
    begin
        case UserInput[1] of
            '1': InputAddTask(listIndex);
            '2': InputShowLists;
            '3': InputDrawHomepage;
            else
        end;
    end;

end;

procedure InputShowTask(listIndex: Integer);
begin
    ClearTerminal;
    ShowTasks(listIndex);

    Write('Which Task do you want to view? Enter index: ');
    ReadLn(UserInput);

end;

procedure ShowTasksOptions(listIndex: Integer);
var
    options: array of string;
begin

    SetLength(options, 4);
    options[0] := 'View Task';
    options[1] := 'Add a new Task';
    options[2] := 'Remove a Task';
    options[3] := 'Go back Home';

    DrawOptions(options);
    if ValidateUserInput(UserInput) then
    begin
        case UserInput[1] of
            '1': InputShowTask(listIndex);
            '2': InputAddTask(listIndex);
            '3': InputRemoveTask(listIndex);
            '4': InputDrawHomepage;
            else
            begin
                InvalidInput();
                InputDrawHomepage;
            end;
        end;
    end
    else
    begin
        InvalidInput();
        InputDrawHomepage;
    end;

end;

procedure ShowTasksOptionsEmpty(listIndex: Integer);
var
    options: array of string;
begin

    SetLength(options, 3);
    options[0] := 'Add a new Task';
    options[1] := 'Remove a Task';
    options[2] := 'Go back Home';

    DrawOptions(options);
    if (UserInput[1] >= '0') and (UserInput[1] <= '9') then
    begin
        case UserInput[1] of
            '1': InputAddTask(listIndex);
            '2': InputRemoveTask(listIndex);
            '3': InputDrawHomepage;
            else
            begin
                InvalidInput();
                InputDrawHomepage;
            end;
        end;
    end
    else
    begin
        InvalidInput();
        InputDrawHomepage;
    end;

end;

procedure InputShowTasks;
var
    atoi: Integer;
    tasksNotEmpty: Boolean;
begin

    ClearTerminal;
    ShowLists;

    Write('Which List do you want to view? Enter index: ');
    ReadLn(UserInput);

    if (UserInput[1] >= '0') and (UserInput[1] <= '9') then
    begin

        atoi := Ord(UserInput[1]) - Ord('0');

        if atoi > Length(lists) then
        begin
            InvalidInput();
            InputDrawHomepage;
        end
        else
        begin
            tasksNotEmpty := ShowTasks(atoi - 1);
            if tasksNotEmpty then
                ShowTasksOptions(atoi - 1)
            else
                ShowTasksOptionsEmpty(atoi - 1);
        end;
    end
    else
    begin
        InvalidInput();
        InputDrawHomepage;
    end;


    ClearTerminal;

end;

// returns false if empty
function ShowLists: Boolean;
var
    i: Integer;
begin

    WriteLn('These are your Lists:');

    if Length(lists) >= 1 then
    begin
        for i := 0 to Length(lists) - 1 do
        begin
            WriteLn('# ', i + 1, '   ', lists[i].ListName, '    ', lists[i].ListDescription);
        end;
        Result := true;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'You currently have no lists.' + #27'[0m');
        Result := false;
    end;
end;

procedure InputShowLists;
var
    options: array of string;
    listNotEmpty: Boolean;
begin

    ClearTerminal;

    listNotEmpty := ShowLists;

    if listNotEmpty then
    begin
        SetLength(options, 2);
        options[0] := 'View Tasks';
        options[1] := 'Go back Home';
    end
    else
    begin
        SetLength(options, 1);
        options[0] := 'Go back Home';
    end;

    DrawEmptyLines(2);

    DrawOptions(options);
    if ValidateUserInput(UserInput, Length(options)-1) then
    begin
        case UserInput[1] of
            '1':
            begin
                if listNotEmpty then
                    InputShowTasks
                else
                    InputDrawHomepage;
            end;
            '2':
            begin
                if listNotEmpty then
                    InputDrawHomepage
                else
                begin
                    InvalidInput();
                    InputDrawHomepage;
                end;
            end;
            else
            begin
                InvalidInput();
                InputDrawHomepage;
            end;
        end;
    end;
end;

procedure AddList(newList: TList);
begin
    SetLength(lists, Length(lists) + 1);
    lists[Length(lists)-1] := newList;
end;

procedure InputAddList;
var
    listName: string;
    listDescription: string;
    newList: TList;
    options: array of string;
begin

    ClearTerminal;

    WriteLn('What should be the name of the list?');
    ReadLn(listName);

    WriteLn('What should be the description of the list?');
    ReadLn(listDescription);

    newList.ListName := listName;
    newList.ListDescription := listDescription;

    ClearTerminal;

    WriteLn('You Created list with name: ', newList.ListName);
    AddList(newList);

    ShowLists;

    DrawEmptyLines(2);



    SetLength(options, 2);
    options[0] := 'Add another List';
    options[1] := 'Go back Home';
    DrawOptions(options);

    if Length(UserInput) >= 1 then
    begin
        if (UserInput[1] >= '0') and (UserInput[1] <= '9') then
        begin
            case UserInput[1] of
                '1': InputAddList;
                '2': InputDrawHomepage;
                else
                begin
                    InvalidInput();
                end;
            end;
        end;
    end;

end;

procedure InputDrawHomepage;
var
    options: array of string;
begin

    ClearTerminal;

    SetLength(options, 3);
    options[0] := 'View Lists';
    options[1] := 'Add a List';
    options[2] := 'Exit Program';
    DrawOptions(options);
    if (Length(UserInput) <= 1) then
    begin
        case UserInput[1] of
            '1': InputShowLists;
            '2': InputAddList;
            '3': exit;
            else
            begin
                WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
                DrawEmptyLines(1);
                WriteLn('Press any button to go back home...');
            end;
        end;
    end
    else
    begin
        WriteLn(#27'[38;5;88m' + 'That was an invalid input.' + #27'[0m');
        InputDrawHomepage;
    end;

end;



begin

    InputDrawHomepage;

end.