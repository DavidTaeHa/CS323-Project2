% Get User Input
prompt = "What is the file name of your test case?";

% Stores the name of the txt file
txtFile = input(prompt, "s");

% Opens the txt file
openFile = fopen(txtFile); 

% Gets all the necessary stuff from the txt file
variables = textscan(openFile,'%s','delimiter','\n'); 

% Closes the file
fclose(openFile);

% Create and store the parameters from txt 
y = inline(char(variables{1}(1)),'x');
a = double(str2double(char(variables{1}(2))));
b = double(str2double(char(variables{1}(3))));
subIntervals = double(str2double(char(variables{1}(4))));


% Calculate delta x
deltaX = (b-a)/subIntervals;

% Run Simpson's Rule
currentX = a; %This will be the changing value of x we will be plugging into f(x)
evenOdd = 0; % This will be our control variable for whether or not we multiply by 2 or 4
approximation = 0; % This will be where our approximation is stored
for i = 1:subIntervals
    % If the value we're plugging in is A, we don't multiply it by anything
    if currentX == a
        approximation = approximation + y(currentX);
        currentX = currentX + deltaX;
        
    % Else, we either multiply f(xn) by 4 or 2
    else
        if rem(evenOdd,2) == 0
            approximation = approximation + 4*y(currentX);
            currentX = currentX + deltaX;
        else
            approximation = approximation + 2*y(currentX);
            currentX = currentX + deltaX;
        end
        evenOdd = evenOdd + 1;
    end
    
end

% We add in f(b) to the approximation
approximation = approximation + y(currentX);

% We multiply in deltax/3
approximation = (deltaX/3)*approximation;

% Print our Approximation
fprintf('Approximation: %f\n', approximation);





