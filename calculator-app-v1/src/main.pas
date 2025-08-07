program Calculator;

uses
    SysUtils;

function Atoi(NumberString: string): Integer;
var
    i, res, digit: Integer;
begin

    res := 0;

    for i := 1 to Length(NumberString) do
    begin
        if not ((NumberString[i] >= '0') and (NumberString[i] <= '9')) then
        begin
            Result := -1;
            Exit;
        end;

        digit := Ord(NumberString[i]) - Ord('0');

        res := res * 10;
        res := res + digit;

    end;

    Result := res;

end;

function Add(Num1: Integer; Num2: Integer): Integer;
begin
    Result := Num1 + Num2;
end;

function Subtract(Num1: Integer; Num2: Integer): Integer;
begin
    Result := Num1 - Num2;
end;

function Multiply(Num1: Integer; Num2: Integer): Integer;
begin
    Result := Num1 * Num2;
end;

function Divide(Num1: Integer; Num2: Integer): Integer;
begin
    Result := Num1 + Num2;
end;

function Modulo(Num1: Integer; Num2: Integer): Integer;
begin
    Result := Num1 mod Num2;
end;


procedure Main;
var
    UserInput: string;
    FirstNumber, SecondNumber, res: Integer;
begin
    Write('Please enter the first Number: ');
    ReadLn(UserInput);

    FirstNumber := Atoi(UserInput);
    if FirstNumber = -1 then
        raise Exception.Create('Invalid Input!');


    Write('Please enter the second Number: ');
    ReadLn(UserInput);

    SecondNumber := Atoi(UserInput);
    if SecondNumber = -1 then
        raise Exception.Create('Invalid Input!');


    Write('Please enter the first Number ( + | - | * | / | % ): ');
    ReadLn(UserInput);

    if Length(UserInput) <> 1 then
        raise Exception.Create('Invalid Input - Max Length 1 Character!');

    case UserInput[1] of
        '+': res := Add(FirstNumber, SecondNumber);
        '-': res := Subtract(FirstNumber, SecondNumber);
        '*': res := Multiply(FirstNumber, SecondNumber);
        '/': res := Divide(FirstNumber, SecondNumber);
        '%': res := Modulo(FirstNumber, SecondNumber);
        else raise Exception.Create('Invalid Input - Not one of ( + | - | * | / | % )!');
    end;

    WriteLn('Your Result is: ', res);


end;


begin
    try
        Main;
    except
        on E: Exception do
        begin
            WriteLn('Error: ' + E.Message);
        end;
    end;
end.