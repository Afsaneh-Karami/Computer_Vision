% loding information
a=readmatrix("a.csv");
b=readmatrix("b.csv");
x=readmatrix("x.csv");
y=readmatrix("y.csv");
%calculate the noise and assess its distribution bu lilliatest
na=a-x;
nb=b-y;
na_mean=mean(na);
nb_mean=mean(nb);
nu_std=std(na);
nv_std=std(nb);
[hx, px] = lillietest(na)
[hy,py] = lillietest(nb)
histogram(na,5);
xlabel('noise in x direction');
ylabel('frequently');
figure,histogram(nb,5); 
xlabel('noise in y direction');
ylabel('frequently');
% erroe calculation comparing noisy data and real value
error_noisedata=sqrt((a-x).^2+(b-y).^2);
mean_error_noisedata=mean(error_noisedata)
std_error_noisedata=std(error_noisedata)
RMSP_noisedata=sqrt(mean(sqrt((a-x).^2+(b-y).^2)))
z = [a; b];
%creat a array of time
t=zeros(size(x));
w=size(x);
for i=1:w(2)-1
    t(i+1)=t(i)+0.2;
end
%plot x and y regarding to time and plot a function to y for constant accerelation
plot(t,x,'+b')
xlabel('time')
ylabel('x position')
figure,plot(t,y,'+b')
p = polyfit(t, y, 2);
xfit = linspace(min(t), max(t), 100);
yfit = polyval(p, xfit);
hold on, plot(t, y, 'o', xfit, yfit);
xlabel('time')
ylabel('y position')
hold off
% applying extended kalman filter 
min_RMSP=100;
validgate_array = 0:5:150; % Create an array of validgate values
RMSP_array = []; % Create an empty array for RMSP values
for validgate = validgate_array
    [px, py] = kalmanExTracking(z,validgate);
    RMSP = sqrt(mean(sqrt((px-x).^2+(py-y).^2)));
    RMSP_array = [RMSP_array, RMSP];
    if RMSP<min_RMSP
        min_RMSP=RMSP;
        validgate_opt=validgate;
    end
end
validgate_opt=validgate_opt
[px, py] = kalmanExTracking(z,validgate_opt);
figure,plot(validgate_array, RMSP_array); % Plot the RMSP values against validgate values
xlabel('Validgate');
ylabel('RMS');


% plot the estimated state with real and noisy state
figure,plot(x, y, 'xb');
hold on,
plot(px, py, '+r');
plot(a, b, 'c*'),
xlabel('xposition')
ylabel('y position')
legend('real state', 'estimated sate', 'noisy state','Location', 'northwest')
hold off;
% erroe calculation comparing estimated data and real value
error=sqrt((px-x).^2+(py-y).^2);
mean_error=mean(error)
std_error=std(error)
RMSP=sqrt(mean(sqrt((px-x).^2+(py-y).^2)))


