%Cubic Spline
clear
format long;
% Get User Input
prompt = "What is the file name of your test case?";

% Stores the name of the txt file
txtFile = input(prompt, "s");

% Opens the txt file
openFile = fopen(txtFile); 

% Gets all the necessary stuff from the txt file
variables = fscanf(openFile,'%f'); 

% Closes the file
fclose(openFile);

count = variables(1); %number of points
xvals = [];
yvals = [];

%Adds inputs to an array
for i=2:length(variables)
    temp = variables(i);
    if (mod(i,2) == 0)
        xvals = [xvals, temp];
    elseif (mod(i,2) ~= 0)
        yvals = [yvals, temp];
    end
end

%adding 1's to the main matrix
main_matrix = zeros(count);
main_matrix(1,1) = 1;
main_matrix(count,count) = 1;

%getting h vals
h = [];
for i=1:count-1
    temp = xvals(i+1)-xvals(i);
    h = [h, temp];
end

h_mid = [];
for i=1:count-2
    temp = 2*(h(i+1)+h(i));
    h_mid = [h_mid, temp];
end

%Constructing main matrix
for i=2:count-1
    main_matrix(i,i-1) = h(i-1);
    main_matrix(i,i) = h_mid(i-1);
    main_matrix(i,i+1) = h(i);
end

%Constructing b of Ax=b
bVec = zeros([count 1]);
for i=2:count-1
    temp = (3/h(i))*(yvals(i+1)-yvals(i))-(3/h(i-1))*(yvals(i)-yvals(i-1));
    bVec(i,1) = temp;
end

%Setting a vector to yvals
a = yvals;

%calculating c vector or x of Ax=b
temp = inv(main_matrix);
c = temp*bVec;

%calculating d vector
d = zeros(1,count-1);
for i=1:count-1
    d(1,i) = (1/(3*h(i)))*(c(i+1)-c(i));
end

%calculating b vector
b = zeros(1,count-1);
for i=1:count-1
    b(1,i) = ((a(i+1)-a(i))/(h(i)))-(((2*c(i)+c(i+1))/3)*h(i));
end

%Forming matrix of coefficients of the polynomials
a(count) = [];
c(count) = [];
c = transpose(c);
coefficients = [a;b;c;d];
coefficients = transpose(coefficients);
display(coefficients);

%plotting polynomials onto a graph
for i=1:count-1
    x = linspace(xvals(i),xvals(i+1));
    y = a(i) + b(i)*(x - xvals(i)) + c(i)*(x - xvals(i)).^2 + d(i)*(x - xvals(i)).^3;
    plot(x,y);
    if i == 1
        hold on
    end
end
hold off
grid
