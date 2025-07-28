clc
clear
 
%% ģ������
%��ʶˮƽΪ0.9��loss Aversion coefficient 2.25

% ����������Լ����������
nvars = 5; % ��������
% Լ��������ʽ1�����������ޣ�����ȡ������[]��
% lb<= X <= ub
lb = [0 0 0 0 0];
ub = [0.2992 0.5284 1 1 0.3673];
% Լ��������ʽ2�����Բ���ʽԼ��������ȡ������[]��
% A*X <= b 
A = [];
b = [];
% Լ��������ʽ3�����Ե�ʽԼ��������ȡ������[]��
% Aeq*X == beq
Aeq = [];
beq = [];
% Լ��������ʽ4��������Լ��������ȡ������[]��
nonlcon = @Con_Fun9;

 
%% ���������
options = gaoptimset();
options.ParetoFraction = 0.3; % ���Ÿ���ϵ��
options.PopulationSize = 200; % ��Ⱥ��С
options.Generations = 200; % ����������
options.StallGenLimit = 200; % ֹͣ����
options.TolFun = 1e-10; % ��Ӧ�Ⱥ���ƫ��
options.HybridFcn = @fgoalattain; % GA�Ż����ó�ʼֵ�����׼�Ż���
objectivesToPlot = [1 2]; % or whatever two objectives you want
seed=20;rng(seed); %������ӣ������������
plotfn = @(options,state,flag)gaplotpareto(options,state,flag,objectivesToPlot);
options = gaoptimset('PlotFcns',plotfn);
%% �����
fitnessfcn = @Obj_Fun9; % ��Ӧ�Ⱥ����ĺ������
% ���

tic
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
toc
 
% ��ͼ
% figure(1)
% surf(fval(:,1),fval(:,2),fval(:,3),fval(:,4),fval(:,4))
% grid on
% shading interp;light;lighting gouraud;

%% ������
result=[x fval];
% xlswrite('���.xlsx',result,1)

