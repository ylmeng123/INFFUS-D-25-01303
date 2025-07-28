clc
clear
 
%% 模型设置
%共识水平为0.9，loss Aversion coefficient 2.25

% 变量个数、约束条件设置
nvars = 5; % 变量个数
% 约束条件形式1：下限与上限（若无取空数组[]）
% lb<= X <= ub
lb = [0 0 0 0 0];
ub = [0.2992 0.5284 1 1 0.3673];
% 约束条件形式2：线性不等式约束（若无取空数组[]）
% A*X <= b 
A = [];
b = [];
% 约束条件形式3：线性等式约束（若无取空数组[]）
% Aeq*X == beq
Aeq = [];
beq = [];
% 约束条件形式4：非线性约束（若无取空数组[]）
nonlcon = @Con_Fun9;

 
%% 求解器设置
options = gaoptimset();
options.ParetoFraction = 0.3; % 最优个体系数
options.PopulationSize = 200; % 种群大小
options.Generations = 200; % 最大进化代数
options.StallGenLimit = 200; % 停止代数
options.TolFun = 1e-10; % 适应度函数偏差
options.HybridFcn = @fgoalattain; % GA优化后获得初始值代入标准优化器
objectivesToPlot = [1 2]; % or whatever two objectives you want
seed=20;rng(seed); %随机种子，帮助结果复现
plotfn = @(options,state,flag)gaplotpareto(options,state,flag,objectivesToPlot);
options = gaoptimset('PlotFcns',plotfn);
%% 主求解
fitnessfcn = @Obj_Fun9; % 适应度函数的函数句柄
% 求解

tic
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);
toc
 
% 画图
% figure(1)
% surf(fval(:,1),fval(:,2),fval(:,3),fval(:,4),fval(:,4))
% grid on
% shading interp;light;lighting gouraud;

%% 输出结果
result=[x fval];
% xlswrite('结果.xlsx',result,1)

