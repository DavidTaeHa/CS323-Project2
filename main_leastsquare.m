clc;clear;close all
data = importdata('data.txt');
p = leastsquare(data);