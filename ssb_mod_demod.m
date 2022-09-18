% INITIALIZING VALUES
close all
fs=200e6;
t=0:1/fs:0.001;
fft_length=1024;
f=linspace(-fs/2,fs/2,fft_length);
 
% MESSAGE SIGNAL
am=1;
fm=8e3;
mt=am*cos(2*pi*fm*t);
fmt=abs(fftshift(fft(mt,fft_length)));
subplot(721)
plot(t*1e3,mt)
title(' (Time Domain) m(t) ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
subplot(722)
plot(f/1e6,fmt)
title (' (Frequency Domain) m(t) ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
% HILBERT TRANSFORMED MESSAGE SIGNAL
am=1;
fm=8e3;
mht=am*sin(2*pi*fm*t);
fmht=abs(fftshift(fft(mht,fft_length)));
subplot(723)
plot(t*1e3,mht)
title(' (Time Domain) mh(t) ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
subplot(724)
plot(f/1e6,fmht)
title (' (Frequency Domain) mh(t) ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
% SSB
fc=25e6;
ssb=mt.*cos(2*pi*fc*t)+mht.*sin(2*pi*fc*t);
subplot(725)
plot(t*1e3,ssb)
title(' (Time Domain) SSB ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
fssb=abs(fftshift(fft(ssb,fft_length)));
subplot(726)
plot(f/1e6,fssb)
title (' (Frequency Domain) SSB ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
% PASSING ACTUAL MESSAGE SIGNAL THROUGH COHERENT DETECTOR
mt1=ssb.*cos(2*pi*fc*t)
subplot(727)
plot(t*1e3,mt1)
title(' (Time Domain) m(t)1 ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
fmt1=abs(fftshift(fft(mt1,fft_length)));
subplot(728)
plot(f/1e6,fmt1)
title (' (Frequency Domain) m(t)1 ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
% PASSING HILBERT TRANSFORMED SIGNAL THROUGH COHERENT DETECTOR
mht1=ssb.*sin(2*pi*fc*t);
subplot(729)
plot(t*1e3,mht1)
title(' (Time Domain) mh(t)1 ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
fmht1=abs(fftshift(fft(mht1,fft_length)));
subplot(7,2,10)
plot(f/1e6,fmht1)
title (' (Frequency Domain) mh(t)1 ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
% DEMODULATING ACTUAL MESSAGE SIGNAL AND HILBERT TRANSFORMED SIGNAL
fcut=10e3
wn=(2/fs)*fcut;
b=fir1(100,wn,'low');
x=filter(b,1,mt1);
subplot(7,2,11)
plot(t*1e3,x)
title(' (Time Domain demod) m(t) ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
fx=abs(fftshift(fft(x,fft_length)));
subplot(7,2,12)
plot(f/1e6,fx)
title (' (Frequency Domain) demod m(t) ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
 
x1=filter(b,1,mht1);
subplot(7,2,13)
plot(t*1e3,x1)
title(' (Time Domain demod) mh(t) ')
xlabel('Time in miliseconds')
ylabel('Amplitude')
fx1=abs(fftshift(fft(x1,fft_length)));
subplot(7,2,14)
plot(f/1e6,fx1)
title (' (Frequency Domain) demod mh(t) ')
xlabel('Freuqency in MHz')
ylabel('Magnitude')
