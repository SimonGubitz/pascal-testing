unit Inputs;

interface

uses
    SysUtils, Globals, Types, List, Task, Utils;

procedure DrawOptions(Options: array of string);
procedure InputShowLists;
procedure InputAddList;
procedure InputRemoveTask(ListIndex: Integer);
procedure InputAddTask(listIndex: Integer);
procedure InputShowTask(listIndex: Integer);
procedure InputShowTasks;
procedure ShowTasksOptions(listIndex: Integer);
procedure ShowTasksOptionsEmpty(listIndex: Integer);



implementation

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
                    Exit;
            end;
            '2':
            begin
                if listNotEmpty then
                    Exit
                else
                begin
                    InvalidInput();
                    Exit;
                end;
            end;
            else
            begin
                InvalidInput();
                Exit;
            end;
        end;
    end;
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
                '2': Exit;
                else
                begin
                    InvalidInput();
                end;
            end;
        end;
    end;

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
        if TaskIndex > Length(Lists[ListIndex].ListEntities) then
        begin
            InvalidInput();
            Exit;
        end
        else
        begin
            RemoveTask(ListIndex, TaskIndex);
            InputShowLists;
        end;
    end;

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
        Exit;
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
            '3': Exit;
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

        if atoi > Length(Lists) then
        begin
            InvalidInput();
            Exit;
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
        Exit;
    end;


    ClearTerminal;

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
            '4': Exit;
            else
            begin
                InvalidInput();
                Exit;
            end;
        end;
    end
    else
    begin
        InvalidInput();
        Exit;
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
            '3': Exit;
            else
            begin
                InvalidInput();
                Exit;
            end;
        end;
    end
    else
    begin
        InvalidInput();
        Exit;
    end;

end;


end.