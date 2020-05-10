%% 适配值函数     
%输入：
%成本
%输出：
%个体的适应度值
function FitnV=Fitness(len)
FitnV=1./len;%适应度是成本的倒数
