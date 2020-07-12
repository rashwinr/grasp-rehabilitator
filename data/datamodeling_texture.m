clc
clear all
close all
loadData_gr
SIDnum = unique(grdata.SubjectID);
grdata.Trial = categorical(grdata.Trial);
grdata.SubjectID = categorical(grdata.SubjectID);
grdata.Texture = categorical(grdata.Texture);
toDelete = grdata.Trial == 'Trial 1';
grdata(toDelete,:) = [];

grdata.log_PLFR = log(grdata.PLFR);
grdata.log_PGFR = log(grdata.PGFR);
grdata.Weightcentered = grdata.Weight - mean(unique(grdata.Weight));
SID = unique(grdata.SubjectID);
Weight = unique(grdata.Weight);
grdata.sfc = zeros(height(grdata),1);
grdata.sfc_inverse = zeros(height(grdata),1);
% A1 = 0.94; A2 = 1; B1 = 0.5; B2 = 0.59; C1 = 1.17;

for i = 1:height(grdata)
   if grdata.Texture(i) == 'A1'
       grdata.sfc(i)=0.94;
       grdata.sfc_inverse(i) = 1/0.94;
   end
   if grdata.Texture(i) == 'A2'
       grdata.sfc(i)=1;
       grdata.sfc_inverse(i) = 1;
   end
   if grdata.Texture(i) == 'B1'
       grdata.sfc(i)=0.5;
       grdata.sfc_inverse(i) = 2;
   end
   if grdata.Texture(i) == 'B2'
       grdata.sfc(i)=0.59;
       grdata.sfc_inverse(i) = 1/0.59;
   end
   if grdata.Texture(i) == 'C1'
       grdata.sfc(i)=1.17;
       grdata.sfc_inverse(i) = 1/1.17;
   end
   
end
grdata.log_sfc = log(grdata.sfc_inverse);
grdata.sfc_centered = grdata.log_sfc-mean(unique(grdata.log_sfc));
grdata.sfc_cent = grdata.sfc-mean(unique(grdata.sfc));

%% PLFR vs. Texture (Log model)

plfr_lme1_log = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_centered');
plfr_lme2_log = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_centered + (1|SubjectID)');
plfr_lme3_log = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_centered + (1+sfc_centered|SubjectID)');
fe1 = fixedEffects(plfr_lme3_log);
[~,~,re1] = randomEffects(plfr_lme3_log);
re1.Level = nominal(re1.Level);
re1.Name = nominal(re1.Name);
plfr_lme4_log = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_centered + (1+sfc_centered|SubjectID) + (1|Trial)');

                comp_plfr_log = compare(plfr_lme1_log,plfr_lme2_log,'nsim',100);
                comp_plfr1_log = compare(plfr_lme2_log,plfr_lme3_log,'nsim',100);
                comp_plfr2_log = compare(plfr_lme3_log,plfr_lme4_log,'nsim',100);
                
plfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PLFR);

f1 = figure(1);
hold on
sgtitle('Log Peak load Force Rate (N/s) vs. log slip ratio')

subplot(3,5,1)
hold on
A1 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PLFR,'*r','DisplayName','PLFR');
B1 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,plfr_lm_1.Coefficients.Estimate(1)+plfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2,'DisplayName','OLS-model');
C1 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,plfr_lm_2.Coefficients.Estimate(1)+plfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,plfr_lm_3.Coefficients.Estimate(1)+plfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,plfr_lm_4.Coefficients.Estimate(1)+plfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,plfr_lm_5.Coefficients.Estimate(1)+plfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,plfr_lm_6.Coefficients.Estimate(1)+plfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,plfr_lm_7.Coefficients.Estimate(1)+plfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,plfr_lm_8.Coefficients.Estimate(1)+plfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,plfr_lm_9.Coefficients.Estimate(1)+plfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,plfr_lm_10.Coefficients.Estimate(1)+plfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,plfr_lm_11.Coefficients.Estimate(1)+plfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,plfr_lm_12.Coefficients.Estimate(1)+plfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(12))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,plfr_lm_13.Coefficients.Estimate(1)+plfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,plfr_lm_14.Coefficients.Estimate(1)+plfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,plfr_lm_15.Coefficients.Estimate(1)+plfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

han1 = axes(f1,'visible','off');
han1.XLabel.Visible = 'on';
han1.YLabel.Visible = 'on';
xlabel(han1,'Log Slip Ratio','FontSize',20);
ylabel(han1,'Log PLFR: Peak Lpad Force Rate (N/s)','FontSize',20);
lgd1 = legend([A1,B1,C1],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd1.Orientation = 'horizontal';

%% PGFR vs. Texture (log model)

pgfr_lme1_log = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_centered');
pgfr_lme2_log = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_centered + (1|SubjectID)');
pgfr_lme3_log = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_centered + (1+sfc_centered|SubjectID)');
fe1 = fixedEffects(pgfr_lme3_log);
[~,~,re1] = randomEffects(pgfr_lme3_log);
re1.Level = nominal(re1.Level);
re1.Name = nominal(re1.Name);
pgfr_lme4_log = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_centered + (1+sfc_centered|SubjectID) + (1|Trial)');

                comp_pgfr_log = compare(pgfr_lme1_log,pgfr_lme2_log,'nsim',100);
                comp_pgfr1_log = compare(pgfr_lme2_log,pgfr_lme3_log,'nsim',100);
                comp_pgfr2_log = compare(pgfr_lme3_log,pgfr_lme4_log,'nsim',100);
                
pgfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PGFR);

f2 = figure(2);
hold on
sgtitle('Log Peak Grip Force Rate (N/s) vs. log slip ratio')

subplot(3,5,1)
hold on
A2 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PGFR,'*r','DisplayName','PGFR');
B2 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,pgfr_lm_1.Coefficients.Estimate(1)+pgfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2,'DisplayName','OLS-model');
C2 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,pgfr_lm_2.Coefficients.Estimate(1)+pgfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,pgfr_lm_3.Coefficients.Estimate(1)+pgfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,pgfr_lm_4.Coefficients.Estimate(1)+pgfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,pgfr_lm_5.Coefficients.Estimate(1)+pgfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,pgfr_lm_6.Coefficients.Estimate(1)+pgfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,pgfr_lm_7.Coefficients.Estimate(1)+pgfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,pgfr_lm_8.Coefficients.Estimate(1)+pgfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,pgfr_lm_9.Coefficients.Estimate(1)+pgfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,pgfr_lm_10.Coefficients.Estimate(1)+pgfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,pgfr_lm_11.Coefficients.Estimate(1)+pgfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,pgfr_lm_12.Coefficients.Estimate(1)+pgfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(12))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,pgfr_lm_13.Coefficients.Estimate(1)+pgfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,pgfr_lm_14.Coefficients.Estimate(1)+pgfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,pgfr_lm_15.Coefficients.Estimate(1)+pgfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == 'sfc_centered'))*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc_centered,'-k','LineWidth',2)
hold off

han2 = axes(f2,'visible','off');
han2.XLabel.Visible = 'on';
han2.YLabel.Visible = 'on';
xlabel(han2,'Log Slip Ratio','FontSize',20);
ylabel(han2,'Log PGFR: Peak Grip Force Rate (N/s)','FontSize',20);
lgd2 = legend([A2,B2,C2],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd2.Orientation = 'horizontal';


%% PLFR vs. Texture (Log-linear model)

plfr_lme1_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_cent');
plfr_lme2_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_cent + (1|SubjectID)');
plfr_lme3_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_cent + (1+sfc_cent|SubjectID)');
fe1 = fixedEffects(plfr_lme3_loglinear);
[~,~,re1] = randomEffects(plfr_lme3_loglinear);
re1.Level = nominal(re1.Level);
re1.Name = nominal(re1.Name);
plfr_lme4_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PLFR ~ sfc_cent + (1+sfc_cent|SubjectID) + (1|Trial)');

                comp_plfr_loglinear = compare(plfr_lme1_loglinear,plfr_lme1_loglinear,'nsim',100);
                comp_plfr1_loglinear = compare(plfr_lme1_loglinear,plfr_lme3_loglinear,'nsim',100);
                comp_plfr2_loglinear = compare(plfr_lme3_loglinear,plfr_lme4_loglinear,'nsim',100);
                
plfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PLFR);
plfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PLFR);

f3 = figure(3);
hold on
sgtitle('Log Peak load Force Rate (N/s) vs. Static friction coefficient')

subplot(3,5,1)
hold on
A3 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PLFR,'*r','DisplayName','PLFR');
B3 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,plfr_lm_1.Coefficients.Estimate(1)+plfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2,'DisplayName','OLS-model');
C3 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,plfr_lm_2.Coefficients.Estimate(1)+plfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,plfr_lm_3.Coefficients.Estimate(1)+plfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,plfr_lm_4.Coefficients.Estimate(1)+plfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,plfr_lm_5.Coefficients.Estimate(1)+plfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,plfr_lm_6.Coefficients.Estimate(1)+plfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,plfr_lm_7.Coefficients.Estimate(1)+plfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,plfr_lm_8.Coefficients.Estimate(1)+plfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,plfr_lm_9.Coefficients.Estimate(1)+plfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,plfr_lm_10.Coefficients.Estimate(1)+plfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,plfr_lm_11.Coefficients.Estimate(1)+plfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,plfr_lm_12.Coefficients.Estimate(1)+plfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(12))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,plfr_lm_13.Coefficients.Estimate(1)+plfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,plfr_lm_14.Coefficients.Estimate(1)+plfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PLFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,plfr_lm_15.Coefficients.Estimate(1)+plfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

han3 = axes(f3,'visible','off');
han3.XLabel.Visible = 'on';
han3.YLabel.Visible = 'on';
xlabel(han3,'Static friction coefficient','FontSize',20);
ylabel(han3,'Log PLFR: Peak Lpad Force Rate (N/s)','FontSize',20);
lgd3 = legend([A3,B3,C3],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd3.Orientation = 'horizontal';

%% PGFR vs. Texture (loglinear model)

pgfr_lme1_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_cent');
pgfr_lme2_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_cent + (1|SubjectID)');
pgfr_lme3_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_cent + (1+sfc_cent|SubjectID)');
fe1 = fixedEffects(pgfr_lme3_loglinear);
[~,~,re1] = randomEffects(pgfr_lme3_loglinear);
re1.Level = nominal(re1.Level);
re1.Name = nominal(re1.Name);
pgfr_lme4_loglinear = fitlme(grdata(grdata.Weight == 250,:),'log_PGFR ~ sfc_cent + (1+sfc_cent|SubjectID) + (1|Trial)');

                comp_pgfr_loglinear = compare(pgfr_lme1_loglinear,pgfr_lme2_loglinear,'nsim',100);
                comp_pgfr1_loglinear = compare(pgfr_lme2_loglinear,pgfr_lme3_loglinear,'nsim',100);
                comp_pgfr2_loglinear = compare(pgfr_lme3_loglinear,pgfr_lme4_loglinear,'nsim',100);
                
pgfr_lm_1 = fitlm(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_2 = fitlm(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_3 = fitlm(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_4 = fitlm(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_5 = fitlm(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_6 = fitlm(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_7 = fitlm(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_8 = fitlm(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_9 = fitlm(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_10 = fitlm(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_11 = fitlm(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_12 = fitlm(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_13 = fitlm(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_14 = fitlm(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PGFR);
pgfr_lm_15 = fitlm(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PGFR);

f4 = figure(4);
hold on
sgtitle('Log Peak Grip Force Rate (N/s) vs. static friction coefficient')

subplot(3,5,1)
hold on
A4 = scatter(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).log_PGFR,'*r','DisplayName','PGFR');
B4 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,pgfr_lm_1.Coefficients.Estimate(1)+pgfr_lm_1.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2,'DisplayName','OLS-model');
C4 = plot(grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(1))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(1) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2,'DisplayName','LME-model');
hold off

subplot(3,5,2)
hold on
scatter(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,pgfr_lm_2.Coefficients.Estimate(1)+pgfr_lm_2.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(2) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,3)
hold on
scatter(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,pgfr_lm_3.Coefficients.Estimate(1)+pgfr_lm_3.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(3))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(3) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,4)
hold on
scatter(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,pgfr_lm_4.Coefficients.Estimate(1)+pgfr_lm_4.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(4))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(4) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,5)
hold on
scatter(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,pgfr_lm_5.Coefficients.Estimate(1)+pgfr_lm_5.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(5))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(5) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,6)
hold on
scatter(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,pgfr_lm_6.Coefficients.Estimate(1)+pgfr_lm_6.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(6))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(6) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,7)
hold on
scatter(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,pgfr_lm_7.Coefficients.Estimate(1)+pgfr_lm_7.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(7))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(7) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,8)
hold on
scatter(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,pgfr_lm_8.Coefficients.Estimate(1)+pgfr_lm_8.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(8))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(8) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,9)
hold on
scatter(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,pgfr_lm_9.Coefficients.Estimate(1)+pgfr_lm_9.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(9))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(9) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,10)
hold on
scatter(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,pgfr_lm_10.Coefficients.Estimate(1)+pgfr_lm_10.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(10))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(10) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,11)
hold on
scatter(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,pgfr_lm_11.Coefficients.Estimate(1)+pgfr_lm_11.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(11))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(11) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,12)
hold on
scatter(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,pgfr_lm_12.Coefficients.Estimate(1)+pgfr_lm_12.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(2))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(12))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(12) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,13)
hold on
scatter(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,pgfr_lm_13.Coefficients.Estimate(1)+pgfr_lm_13.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(13))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(13) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,14)
hold on
scatter(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,pgfr_lm_14.Coefficients.Estimate(1)+pgfr_lm_14.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(14))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(14) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

subplot(3,5,15)
hold on
scatter(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).log_PGFR,'*r')
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,pgfr_lm_15.Coefficients.Estimate(1)+pgfr_lm_15.Coefficients.Estimate(2)*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,'-.b','LineWidth',2)
plot(grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc,fe1(1)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == '(Intercept)')+(fe1(2)+re1.Estimate(re1.Level == num2str(SIDnum(15))&re1.Name == 'sfc_cent'))*grdata(grdata.SubjectID==SID(15) & grdata.Weight == 250,:).sfc_cent,'-k','LineWidth',2)
hold off

han4 = axes(f4,'visible','off');
han4.XLabel.Visible = 'on';
han4.YLabel.Visible = 'on';
xlabel(han4,'Static friction coefficient','FontSize',20);
ylabel(han4,'Log PGFR: Peak Grip Force Rate (N/s)','FontSize',20);
lgd4 = legend([A4,B4,C4],'FontSize',20);
% set(lgd2,'MarkerSize',20);
lgd4.Orientation = 'horizontal';

%% Model comparison and R^2 values

PLFR_log_Rsquared = [plfr_lme1_log.Rsquared.Ordinary;plfr_lme2_log.Rsquared.Ordinary;plfr_lme3_log.Rsquared.Ordinary;plfr_lme4_log.Rsquared.Ordinary]
PGFR_log_Rsquared = [pgfr_lme1_log.Rsquared.Ordinary;pgfr_lme2_log.Rsquared.Ordinary;pgfr_lme3_log.Rsquared.Ordinary;pgfr_lme4_log.Rsquared.Ordinary]
PLFR_loglinear_Rsquared = [plfr_lme1_loglinear.Rsquared.Ordinary;plfr_lme2_loglinear.Rsquared.Ordinary;plfr_lme3_loglinear.Rsquared.Ordinary;plfr_lme4_loglinear.Rsquared.Ordinary]
PGFR_loglinear_Rsquared = [pgfr_lme1_loglinear.Rsquared.Ordinary;pgfr_lme2_loglinear.Rsquared.Ordinary;pgfr_lme3_loglinear.Rsquared.Ordinary;pgfr_lme4_loglinear.Rsquared.Ordinary]

compare(plfr_lme3_log,plfr_lme3_loglinear)
compare(pgfr_lme3_log,pgfr_lme3_loglinear)

%% Mixed effects of weight and texture on PLFR (power model)

% PLFR = alpha * W^(Beta) * T^(Gamma)
% log(PLFR) = log(alpha) + Beta*log(W) + Gamma*log(T)

grdata.logweight = log(grdata.Weight);
grdata.logweightcentered = grdata.logweight - mean(unique(grdata.logweight));
lplfr_lme11 = fitlme(grdata,'log_PLFR ~ logweightcentered + sfc_centered');
lplfr_lme21 = fitlme(grdata,'log_PLFR ~ logweightcentered + sfc_centered + (1|SubjectID)');
% compare_complete = compare(lplfr_lme11,lplfr_lme2);
fe3 = fixedEffects(lplfr_lme11);
compare_complete1 = compare(lplfr_lme11,lplfr_lme21);
fe4 = fixedEffects(lplfr_lme21);
pweight = linspace(100,1000,100);
plogweight = log(pweight);
plogweightcentered = plogweight-mean(plogweight);
ptexture = linspace(-1,1,100);
ptexturecentered = ptexture - mean(ptexture);
[Wtp,Ttp] = meshgrid(plogweightcentered,ptexturecentered);
Zt = exp(fe4(1) + fe4(2)*Wtp + fe4(3)*Ttp);
figure(5)
surf(pweight,ptexture,Zt);


%% Mixed effects of weight and texture on PGFR (power model)

%PGFR = alpha \times W^(Beta) \times T^(Gamma)
%log(PGFR) = log(alpha) + Beta*log(W) + Gamma*log(T)

lpgfr_lme1 = fitlme(grdata,'log_PGFR ~ logweightcentered + sfc_centered');
lpgfr_lme2 = fitlme(grdata,'log_PGFR ~ logweightcentered + sfc_centered + (1|SubjectID)');
compare_complete1 = compare(lpgfr_lme1,lpgfr_lme2);
fe5 = fixedEffects(lpgfr_lme2);
Zt = exp(fe5(1) + fe5(2)*Wtp + fe5(3)*Ttp);
figure(6)
surf(pweight,ptexture,Zt);

%% Mixed effects of weight and texture on PLFR (power model-2)

%PLFR = alpha * e^(beta*W) * T^(gamma)
%log(PLFR) = log(alpha) + beta*W + gamma log(T)

lplfr_lme21 = fitlme(grdata,'log_PLFR ~ Weightcentered + sfc_centered');
lplfr_lme22 = fitlme(grdata,'log_PLFR ~ Weightcentered + sfc_centered + (1|SubjectID)');
compare_complete2 = compare(lplfr_lme21,lplfr_lme22);
fe6 = fixedEffects(lplfr_lme21);
compare_complete12 = compare(lplfr_lme21,lplfr_lme22);
fe7 = fixedEffects(lplfr_lme22);
pweight = linspace(100,1000,100);
pweightcentered = pweight-mean(pweight);
ptexture = linspace(-1,1,100);
ptexturecentered = ptexture - mean(ptexture);
[Wtp1,Ttp1] = meshgrid(pweightcentered,ptexturecentered);
Zt = exp(fe7(1) + fe7(2)*Wtp1 + fe7(3)*Ttp1);
figure(7)
surf(pweight,ptexture,Zt);

%% Mixed effects of weight and texture on PGFR (power model-2)

%PGFR = alpha \times e^(beta*W) \times T^(Gamma)
%log(PGFR) = log(alpha) + W + Gamma log(T)

lpgfr_lme21 = fitlme(grdata,'log_PGFR ~ Weightcentered + sfc_centered');
lpgfr_lme22 = fitlme(grdata,'log_PGFR ~ Weightcentered + sfc_centered + (1|SubjectID)');
compare_complete1 = compare(lpgfr_lme21,lpgfr_lme22);
fe8 = fixedEffects(lpgfr_lme22);
Zt = exp(fe8(1) + fe8(2)*Wtp1 + fe8(3)*Ttp1);

figure(8)
surf(pweight,ptexture,Zt);

