%This script uses relativistic kinematic equations to solve for the 
%knock-on energies for energy transfer from incident electrons to Au atoms.
%It does so while imaging with acceleration voltages of 300 kV and 200 kV
%(see supplementary text 5).

close all
clear all
clc

theta = [0:5:180].*pi/180; %Range of angles for elastic scattering equation
count = length(theta); 
E_max = [4.3, 2.7]; %E_max for 300-keV and 200-keV electrons, respectively
E_300 = zeros(1,count); %Initialize E vector for 300-keV electrons
E_200 = zeros(1,count); %Initialize E vector for 300-keV electrons
E_300S = zeros(1,count); %Initialize E vector for 300-keV electrons 
                         %on surfaces perpendicular to the beam
Threshold_300 = 0; %Initialize counts for breaking energy threshold
Threshold_200 = 0;
Threshold_300S = 0;

for i = 1:count
    E_300(i) = E_max(1)* ( ( sin(theta(i)/2) )^2 );
    E_200(i) = E_max(2)* ( ( sin(theta(i)/2) )^2 );
    E_300S(i) = E_max(1)* ( ( sin(theta(i)/2) )^2 )* ( ( cos(theta(i)/2) )^2 );
end

for i = 1:count
    if E_300(i) > 3.8
        Threshold_300 = Threshold_300 + 1;
    end
    if E_200(i) > 3.8
        Threshold_200 = Threshold_200 + 1;
    end
    if E_300S(i) > 3.8
        Threshold_300S = Threshold_300S + 1;
    end
end
    
m = [max(E_300), max(E_200), max(E_300S)]
Probabilities = [Threshold_300/count, Threshold_200/count, ...
    Threshold_300S/count]

subplot(2,2,1)
plot(theta,E_300,'x')
title('300 kV')
xlabel('theta (rads)')
ylabel('Transfer Energy (eV)')

subplot(2,2,2)
plot(theta,E_200,'x')
title('200 kV')
xlabel('theta (rads)')
ylabel('Transfer Energy (eV)')

subplot(2,2,3)
plot(theta,E_300S,'x')
title('300 kV (surface)')
xlabel('theta (rads)')
ylabel('Transfer Energy (eV)')